import SwiftDiagnostics
import SwiftSyntax

enum Diagnostics {
    static func diagnose(
        declaration: DeclGroupSyntax
    ) -> SwiftDiagnostics.Diagnostic? {
        // Class, Actor以外の場合は無視する
        guard let tokens = attemptToStructConversion(from: declaration) else {
            return nil
        }

        // Class, Actorの場合に変換エラーを出力する
        return SwiftDiagnostics.Diagnostic(
            node: declaration.root,
            message: DiagnosticSimpleMessage(
                message: "@Builderは構造体のみで有効です",
                diagnosticID: messageID,
                severity: .error
            ),
            fixIts: [
                FixIt(
                    message: DiagnosticSimpleMessage(
                        message: "replace with 'struct'",
                        diagnosticID: messageID,
                        severity: .error
                    ),
                    changes: [
                        FixIt.Change.replace(
                            oldNode: Syntax(tokens.old),
                            newNode: Syntax(tokens.new)
                        )
                    ]
                )
            ]
        )
    }

    private static let messageID = MessageID(
        domain: "BuilderMacro",
        id: "WrongDeclarationKeyword"
    )

    /**
     * Class, ActorをStructに書き換える
     *
     * 【Before】
     * class User {
     *     let name: String
     * }
     *
     * 【After】
     * Actor User {
     *     let name: String
     * }
     */
    private static func attemptToStructConversion(
        from declaration: DeclGroupSyntax
    ) -> (old: TokenSyntax, new: TokenSyntax)? {
        switch declaration {
        case let classDeclaration as ClassDeclSyntax:
            (
                classDeclaration.classKeyword,
                classDeclaration.classKeyword.with(
                    \.tokenKind,
                    .identifier("struct")
                )
            )

        case let actorDeclaration as ActorDeclSyntax:
            (
                actorDeclaration.actorKeyword,
                actorDeclaration.actorKeyword.with(
                    \.tokenKind,
                    .identifier("struct")
                )
            )

        default:
            nil
        }
    }
}
