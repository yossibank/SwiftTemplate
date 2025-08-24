import Foundation

public typealias AppBuild = AppConfiguration.Build

public enum AppConfiguration {
    public enum Build {
        case dev
        case adHoc
        case release

        public nonisolated(unsafe) static var value = Build.dev

        public static var isDev: Bool {
            value == .dev
        }

        public static var isAdHoc: Bool {
            value == .adHoc
        }

        public static var isRelease: Bool {
            value == .release
        }

        public static var isTesting: Bool {
            NSClassFromString("XCTestCase") != nil
        }

        public static var isLogging: Bool {
            isDev && !isTesting
        }
    }
}
