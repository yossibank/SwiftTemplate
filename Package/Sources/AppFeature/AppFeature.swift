import Foundation

public typealias AppDate = AppFeature.Date
public typealias AppDateLocale = AppFeature.Date.Locale

public enum AppFeature {
    public enum Date {
        public static let calendar = Calendar(identifier: .gregorian)

        public enum Locale {
            case jp
            case us

            var value: String {
                switch self {
                case .jp: "ja_JP"
                case .us: "en_US_POSIX"
                }
            }
        }

        public static func dateFormatter(_ locale: Locale) -> DateFormatter {
            .init().apply {
                $0.locale = .init(identifier: locale.value)
                $0.calendar = .init(identifier: .gregorian)
                $0.timeZone = .init(identifier: locale.value)
            }
        }
    }
}
