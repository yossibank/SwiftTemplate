import Foundation

public typealias AppBuild = AppConfiguration.Build

public enum AppConfiguration {
    public enum Build: Int {
        case debug = 1
        case staging
        case release

        public nonisolated(unsafe) static var value = Build.debug

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
}
