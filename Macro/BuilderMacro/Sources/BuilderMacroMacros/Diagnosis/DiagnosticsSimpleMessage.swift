import SwiftDiagnostics
import SwiftSyntax

struct DiagnosticSimpleMessage: DiagnosticMessage, Error {
    let message: String
    let diagnosticID: MessageID
    let severity: DiagnosticSeverity
}

extension DiagnosticSimpleMessage: FixItMessage {
    var fixItID: MessageID {
        diagnosticID
    }
}
