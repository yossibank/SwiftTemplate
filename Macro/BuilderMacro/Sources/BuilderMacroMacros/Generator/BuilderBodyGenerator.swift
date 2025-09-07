import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct BuilderBodyGenerator {
    fileprivate enum Error: Swift.Error {
        case missingDeclarationName
    }

    fileprivate struct TypedVarialble {
        let name: String
        let type: String
    }

    func generateBody(from declaration: DeclGroupSyntax) throws -> [DeclSyntax] {
        guard let memberName = declaration.name else {
            throw Error.missingDeclarationName
        }

        return generateBody(
            memberName: memberName,
            variables: declaration.typedMembers
        )
    }
}

extension BuilderBodyGenerator {
    private func generateBody(
        memberName: String,
        variables: [TypedVarialble]
    ) -> [DeclSyntax] {
        [
            DeclSyntax(createBuilderClass(memberName: memberName, variables: variables)),
            DeclSyntax(createMakeBuilderFunction())
        ]
    }

    private func createBuilderClass(
        memberName: String,
        variables: [TypedVarialble]
    ) -> ClassDeclSyntax {
        try! ClassDeclSyntax("public class Builder") {
            for variable in variables {
                DeclSyntax("\(raw: variable.varDefinition)")
            }

            DeclSyntax(
                """
                \n
                public init() {}
                """
            )

            DeclSyntax(
                """
                \n
                public convenience init(_ item: \(raw: memberName)?) {
                    self.init()
                    fill(with: item)
                }
                """
            )

            DeclSyntax(
                """
                \n
                public func fill(with item: \(raw: memberName)?) {
                    \(raw: variables.fillAssignments)
                }
                """
            )

            for variable in variables {
                DeclSyntax(
                    """
                    \n
                    \(raw: variable.functionDefinition)
                    """
                )
            }

            DeclSyntax(
                """
                \n
                public func build() -> \(raw: memberName)? {
                    \(raw: variables.buildGuards)
                    return \(raw: memberName)(
                        \(raw: variables.initAssignments)
                    )
                }
                """
            )
        }
    }

    private func createMakeBuilderFunction() -> FunctionDeclSyntax {
        try! FunctionDeclSyntax("public static func makeBuilder() -> Builder") {
            ExprSyntax("Builder()")
        }
    }
}

extension [BuilderBodyGenerator.TypedVarialble] {
    var fillAssignments: String {
        map { $0.assignment(from: "item", isOptional: true) }
            .joined(separator: "\n")
    }

    var initAssignments: String {
        map(\.initAssignment)
            .joined(separator: ",\n")
    }

    var buildGuards: String {
        let nonOptionalVars = filter { !$0.isOptional }

        return "guard "
            + nonOptionalVars.compactMap(\.guardCheck).joined(separator: ", ")
            + " else { return nil }"
    }
}

extension BuilderBodyGenerator.TypedVarialble {
    func assignment(
        from property: String,
        isOptional: Bool
    ) -> String {
        "\(name) = \(property + (isOptional ? "?" : "")).\(name)"
    }

    var varDefinition: String {
        "public var \(name): \(optionalType)"
    }

    var functionDefinition: String {
        """
        public func \(name)(_ \(name): \(optionalType)) -> Self {
            self.\(name) = \(name)
            return self
        }
        """
    }

    var initAssignment: String {
        isUUID
            ? "\(name): \(name) ?? UUID()"
            : "\(name): \(name)"
    }

    var guardCheck: String? {
        isUUID
            ? nil
            : "let \(name)"
    }

    var isUUID: Bool {
        name == "uuid"
    }

    var isOptional: Bool {
        type.last == "?"
    }

    private var optionalType: String {
        isOptional ? type : "\(type)?"
    }
}

private extension DeclGroupSyntax {
    /**
     * stored propertiesから文字列で変数名と型を抜き出し構造体のイニシャライズのための配列取得
     */
    var typedMembers: [BuilderBodyGenerator.TypedVarialble] {
        storedVariables.compactMap {
            guard
                let name = $0.name,
                let type = $0.typeString
            else {
                return nil
            }

            return .init(
                name: name,
                type: type
            )
        }
    }
}

extension BuilderBodyGenerator.Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .missingDeclarationName:
            "Unable not find declaration name for type"
        }
    }
}
