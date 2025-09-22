import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct BuilderMacro: MemberMacro {
    enum Error: Swift.Error {
        case wrongDeclarationSyntax
    }

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard declaration.isStruct || declaration.isEnum else {
            guard let diagnostic = Diagnostics.diagnose(
                declaration: declaration
            ) else {
                throw Error.wrongDeclarationSyntax
            }

            context.diagnose(diagnostic)

            return []
        }

        let bodyGenerator = BuilderBodyGenerator()
        return try bodyGenerator.generateBody(from: declaration)
    }
}

@main
struct BuilderMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        BuilderMacro.self
    ]
}

extension BuilderMacro.Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .wrongDeclarationSyntax:
            "Builder Macro supports only structs and enums"
        }
    }
}
