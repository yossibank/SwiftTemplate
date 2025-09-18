import SwiftDiagnostics
import SwiftSyntax

enum Diagnostics {
    static func diagnose(
        declaration: DeclGroupSyntax
    ) -> SwiftDiagnostics.Diagnostic? {
        guard attemptToConversion(from: declaration) else {
            return nil
        }

        // Class, Actor, Struct以外の場合にエラーを出力する
        return SwiftDiagnostics.Diagnostic(
            node: declaration.root,
            message: DiagnosticSimpleMessage(
                message: "@AutoInitはClass, Actor, Structのみで有効です",
                diagnosticID: messageID,
                severity: .error
            )
        )
    }

    private static let messageID = MessageID(
        domain: "AutoInitMacro",
        id: "WrongDeclarationKeyword"
    )

    private static func attemptToConversion(
        from declaration: DeclGroupSyntax
    ) -> Bool {
        switch declaration {
        case _ as ClassDeclSyntax,
             _ as ActorDeclSyntax,
             _ as StructDeclSyntax:
            false

        default:
            true
        }
    }
}
