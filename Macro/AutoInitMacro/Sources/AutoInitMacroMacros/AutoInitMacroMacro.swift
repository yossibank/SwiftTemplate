import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AutoInitMacro: MemberMacro {
    enum Error: Swift.Error {
        case wrongDeclarationSyntax
    }

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let isStruct = declaration.isStruct
        let isClass = declaration.isClass
        let isActor = declaration.isActor

        guard isStruct || isClass || isActor else {
            guard let diagnostic = Diagnostics.diagnose(
                declaration: declaration
            ) else {
                throw Error.wrongDeclarationSyntax
            }

            context.diagnose(diagnostic)

            return []
        }

        let bodyGenerator = AutoInitGenerator()
        return bodyGenerator.generateBody(from: declaration)
    }
}

public struct InitMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        []
    }
}

@main
struct AutoInitMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AutoInitMacro.self,
        InitMacro.self
    ]
}

extension AutoInitMacro.Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .wrongDeclarationSyntax:
            "Builder Macro supports only class, actor, struct"
        }
    }
}
