import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct AutoInitGenerator {
    fileprivate struct TypedVariable {
        let name: String
        let type: String
        let initialValue: String?
        let initialLabel: String?
    }

    func generateBody(from declaration: DeclGroupSyntax) -> [DeclSyntax] {
        generateBody(variables: declaration.typedMembers)
    }
}

extension AutoInitGenerator {
    private func generateBody(variables: [TypedVariable]) -> [DeclSyntax] {
        [
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
        ]
    }
}

extension [AutoInitGenerator.TypedVariable] {
    var initArguments: String {
        map(\.initArgument)
            .joined(separator: ",\n")
    }

    var initDefinisions: String {
        map(\.initDefinition)
            .joined(separator: "\n")
    }
}

extension AutoInitGenerator.TypedVariable {
    var initArgument: String {
        let initialValue = initialValue.map { "= \($0)" } ?? ""
        return "\(labelPrefix)\(name): \(typePrefix)\(initialValue)"
    }

    var initDefinition: String {
        "self.\(name) = \(name)"
    }

    private var labelPrefix: String {
        guard let initialLabel else {
            return ""
        }

        return isUnderScore ? "_ " : "\(initialLabel) "
    }

    private var typePrefix: String {
        isClosure ? "@escaping \(type)" : type
    }

    private var isUnderScore: Bool {
        initialLabel == "_"
    }

    private var isOptional: Bool {
        type.last == "?"
    }

    private var isClosure: Bool {
        !isOptional && type.contains("->")
    }
}

private extension DeclGroupSyntax {
    /**
     * stored propertiesから文字列で変数名と型を抜き出しイニシャライズ作成のための配列取得
     */
    var typedMembers: [AutoInitGenerator.TypedVariable] {
        storedVariables.compactMap {
            guard
                let name = $0.name,
                let type = $0.typeString
            else {
                return nil
            }

            return .init(
                name: name,
                type: type,
                initialValue: $0.initialValueString,
                initialLabel: $0.initialLabel
            )
        }
    }
}

private extension VariableDeclSyntax {
    var initialLabel: String? {
        for attribute in attributes {
            guard
                case let .attribute(attr) = attribute,
                let identifierType = attr.attributeName.as(IdentifierTypeSyntax.self),
                identifierType.name.text == "Init"
            else {
                continue
            }

            guard
                let arguments = attr.arguments,
                case let .argumentList(list) = arguments
            else {
                continue
            }

            for arg in list {
                guard
                    let label = arg.label,
                    let expression = arg.expression.as(StringLiteralExprSyntax.self),
                    label.text == "label"
                else {
                    continue
                }

                let segments = expression.segments

                guard
                    let firstSegment = segments.first,
                    case let .stringSegment(segment) = firstSegment
                else {
                    continue
                }

                return segment.content.text
            }
        }

        return nil
    }
}
