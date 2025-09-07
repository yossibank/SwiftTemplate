import SwiftDiagnostics
import SwiftSyntax

enum DiagnosticsError: Error, CustomStringConvertible {
    case message(String)

    var description: String {
        switch self {
        case let .message(text): text
        }
    }
}
