import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct BuilderBodyGenerator {
    fileprivate enum Error: Swift.Error {
        case missingDeclarationName
    }

    fileprivate struct TypedVariable {
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
        variables: [TypedVariable]
    ) -> [DeclSyntax] {
        [
            DeclSyntax(builderClassDecl(memberName: memberName, variables: variables)),
            DeclSyntax(makeTestBuilderDecl())
        ]
    }

    private func builderClassDecl(
        memberName: String,
        variables: [TypedVariable]
    ) -> ClassDeclSyntax {
        try! ClassDeclSyntax("public class Builder") {
            for variable in variables {
                DeclSyntax("\(raw: variable.varDefinition)")
            }

            DeclSyntax(
                """
                \n
                public init(
                    \(raw: variables.initArguments)
                ) {
                    \(raw: variables.initDefinisions)
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
                public func build() -> \(raw: memberName) {
                    return \(raw: memberName)(
                        \(raw: variables.buildDefinitions)
                    )
                }
                """
            )
        }
    }

    private func makeTestBuilderDecl() -> FunctionDeclSyntax {
        try! FunctionDeclSyntax("public static func makeTestBuilder() -> Builder") {
            ExprSyntax("Builder()")
        }
    }
}

extension [BuilderBodyGenerator.TypedVariable] {
    var initArguments: String {
        map(\.initArgument)
            .joined(separator: ",\n")
    }

    var initDefinisions: String {
        map(\.initDefinition)
            .joined(separator: "\n")
    }

    var buildDefinitions: String {
        map(\.buildDefinition)
            .joined(separator: ",\n")
    }
}

extension BuilderBodyGenerator.TypedVariable {
    var initArgument: String {
        "\(name): \(type) = \(defaultValue)"
    }

    var initDefinition: String {
        "self.\(name) = \(name)"
    }

    var varDefinition: String {
        "public var \(name): \(type)"
    }

    var functionDefinition: String {
        """
        public func \(name)(_ \(name): \(type)) -> Self {
            self.\(name) = \(name)
            return self
        }
        """
    }

    var buildDefinition: String {
        "\(name): \(name)"
    }

    private var isOptional: Bool {
        type.last == "?"
    }

    private var defaultValue: String {
        let baseType = isOptional ? String(type.dropLast()) : type

        if isOptional {
            return "nil"
        } else {
            switch baseType {
            case "String":
                return "\"\""

            case "Int", "Int8", "Int16", "Int32", "Int64":
                return "0"

            case "UInt", "UInt8", "UInt16", "UInt32", "UInt64":
                return "0"

            case "Bool":
                return "false"

            case "Double":
                return "0"

            case "Float":
                return "0"

            case "CGFloat":
                return "0"

            case "Date":
                return "Date()"

            case "UUID":
                return "UUID()"

            case "Data":
                return "Data()"

            case "URL":
                return "URL(string: \"https://www.google.com\")!"

            case "CGPoint":
                return "CGPoint()"

            case "CGRect":
                return "CGRect()"

            case "CGSize":
                return "CGSize()"

            case "CGVector":
                return "CGVector()"

            case "UIColor":
                return "UIColor.clear"

            case let dictType where dictType.contains(":") && dictType.hasPrefix("[") && dictType.hasSuffix("]"):
                return "[:]"

            case let arrayType where arrayType.hasPrefix("[") && arrayType.hasSuffix("]"):
                return "[]"

            case let funcType where funcType.contains("->"):
                if funcType == "() -> Void" {
                    return "{}"
                } else if funcType.hasPrefix("("), funcType.contains(") -> Void") {
                    let paramCount = funcType.components(separatedBy: ",").count
                    let params = (0..<paramCount).map { _ in "_" }.joined(separator: ", ")
                    return "{ \(params) in }"
                } else {
                    return "{}"
                }

            default:
                if baseType.hasSuffix("?") || baseType.hasSuffix("!") {
                    return "nil"
                } else {
                    return "\(baseType).makeTestBuilder().build()"
                }
            }
        }
    }
}

private extension DeclGroupSyntax {
    /**
     * stored propertiesから文字列で変数名と型を抜き出し構造体のイニシャライズのための配列取得
     */
    var typedMembers: [BuilderBodyGenerator.TypedVariable] {
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
