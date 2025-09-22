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

    fileprivate struct InitConfiguration {
        let label: String?
        let value: String?
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
                    \(raw: variables.initDefinitions)
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

    var initDefinitions: String {
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
                initialValue: $0.initConfiguration.value,
                initialLabel: $0.initConfiguration.label
            )
        }
    }
}

private extension VariableDeclSyntax {
    var initConfiguration: AutoInitGenerator.InitConfiguration {
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

            var label: String?
            var value: String?

            for arg in list {
                guard let argLabel = arg.label else {
                    continue
                }

                switch argLabel.text {
                case "label":
                    if let expression = arg.expression.as(StringLiteralExprSyntax.self),
                       let firstSegment = expression.segments.first,
                       case let .stringSegment(segment) = firstSegment {
                        label = segment.content.text
                    }

                case "default":
                    value = arg
                        .expression
                        .description
                        .trimmingCharacters(in: .whitespaces)

                default:
                    break
                }
            }

            return .init(
                label: label,
                value: value
            )
        }

        return .init(
            label: nil,
            value: nil
        )
    }
}
