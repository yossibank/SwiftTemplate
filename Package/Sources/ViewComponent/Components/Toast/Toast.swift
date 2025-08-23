import SwiftUI

public enum Toast {
    case done
    case warning
    case error

    var title: String {
        switch self {
        case .done: "完了"
        case .warning: "警告"
        case .error: "エラー"
        }
    }

    var style: some ShapeStyle {
        switch self {
        case .done: Color.green.opacity(0.8)
        case .warning: Color.yellow.opacity(0.8)
        case .error: Color.red.opacity(0.8)
        }
    }

    var image: Image {
        switch self {
        case .done: .done
        case .warning: .warning
        case .error: .error
        }
    }
}
