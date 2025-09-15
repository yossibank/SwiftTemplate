import Foundation
import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct URLMacro: ExpressionMacro {
    enum Error: Swift.Error {
        case missingArgument
        case argumentNotString
        case invalidURL
        case invalidURLScheme
        case invalidURLHost
    }

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let arugment = node.arguments.first?.expression else {
            throw Error.missingArgument
        }

        guard
            let stringLiteralExpr = arugment.as(StringLiteralExprSyntax.self),
            let segment = stringLiteralExpr.segments.first?.as(StringSegmentSyntax.self),
            stringLiteralExpr.segments.count == 1
        else {
            throw Error.argumentNotString
        }

        let urlString = segment.content.text

        guard let url = URL(string: urlString) else {
            throw Error.invalidURL
        }

        guard
            let scheme = url.scheme,
            ["http", "https"].contains(scheme)
        else {
            throw Error.invalidURLScheme
        }

        guard
            let host = url.host(),
            !host.isEmpty
        else {
            throw Error.invalidURLHost
        }

        return #"URL(string: "\#(raw: urlString)")!"#
    }
}

@main
struct URLMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLMacro.self
    ]
}

extension URLMacro.Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .missingArgument:
            "URL macro requires a string argument"

        case .argumentNotString:
            "URL macro argument must be a string literal"

        case .invalidURL:
            "Invalid URL format"

        case .invalidURLScheme:
            "URL scheme must be 'http' or 'https'"

        case .invalidURLHost:
            "URL must have a valid host"
        }
    }
}
