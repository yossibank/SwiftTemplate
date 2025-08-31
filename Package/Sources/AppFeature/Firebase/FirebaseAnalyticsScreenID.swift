import Foundation

public enum FirebaseAnalyticsScreenID: Sendable {
    case boot
    case search

    public var value: String {
        switch self {
        case .boot: "boot"
        case .search: "search"
        }
    }
}
