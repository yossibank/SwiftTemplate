import AppExtension
import Foundation

public typealias AppConfiguration = AppFoundation.Configuration
public typealias AppDate = AppFoundation.Date
public typealias AppDateLocale = AppFoundation.Date.Locale
public typealias AppError = AppFoundation.AppError
public typealias AppState<T: Equatable> = AppFoundation.AppState<T>
public typealias AppPagingState<T: Equatable> = AppFoundation.AppPagingState<T>

public enum AppFoundation {
    public enum Configuration: Int {
        case debug = 1
        case staging
        case release

        public nonisolated(unsafe) static var value = Configuration.debug

        public static var isDebug: Bool {
            value == .debug
        }

        public static var isStaging: Bool {
            value == .staging
        }

        public static var isRelease: Bool {
            value == .release
        }

        public static var isTesting: Bool {
            NSClassFromString("XCTestCase") != nil
        }

        public static var isLogging: Bool {
            !isRelease && !isTesting
        }

        public var title: String {
            switch self {
            case .debug: "DEBUG"
            case .staging: "STAGING"
            case .release: "RELAESE"
            }
        }

        public init(value: Int?) {
            guard let value else {
                self = .release
                return
            }

            self = .init(rawValue: value) ?? .release
        }
    }

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

    public enum AppError: Error, Equatable {
        case decode
        case timeout
        case notConnectedToInternet
        case emptyResponse
        case invalidRequest
        case invalidStatusCode(Int)
        case unknown
    }

    public enum AppState<T: Equatable & Sendable>: Equatable, Sendable {
        case initial
        case loading
        case error(AppError)
        case loaded(T)
    }

    public enum AppPagingState<T: Equatable & Sendable>: Equatable, Sendable {
        case initial
        case initialLoading
        case additionalLoading
        case initialError(AppError)
        case additionalError(AppError)
        case loaded(items: [T])
    }
}
