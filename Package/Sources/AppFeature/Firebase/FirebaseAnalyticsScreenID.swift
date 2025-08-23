import Foundation

public enum FirebaseAnalyticsScreenID {
    case boot

    public var value: String {
        switch self {
        case .boot: "boot"
        }
    }
}
