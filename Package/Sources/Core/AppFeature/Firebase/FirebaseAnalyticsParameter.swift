import Foundation

public enum FirebaseAnalyticsParameter {
    case bootDate

    public var value: String {
        switch self {
        case .bootDate: "bootDate"
        }
    }
}
