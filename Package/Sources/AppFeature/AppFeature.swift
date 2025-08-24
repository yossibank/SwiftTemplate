import Foundation

public typealias AppDate = AppFeature.Date
public typealias AppDateLocale = AppFeature.Date.Locale
public typealias AppError = AppFeature.AppError
public typealias AppState<T: Equatable> = AppFeature.AppState<T>
public typealias AppPagingState<T: Equatable> = AppFeature.AppPagingState<T>

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

    public enum AppState<T: Equatable>: Equatable {
        case initial
        case loading
        case error(AppError)
        case loaded(T)
    }

    public enum AppPagingState<T: Equatable>: Equatable {
        case initial
        case initialLoading
        case additionalLoading
        case initialError(AppError)
        case additionalError(AppError)
        case loaded(loaded: [T])
    }

    public enum AppError: Error, Equatable {
        case decode
        case timeout
        case notConnectedToInternet
        case emptyResponse
        case invalidRequest
        case invalidStatusCode(Int)
        case unknown
    }
}
