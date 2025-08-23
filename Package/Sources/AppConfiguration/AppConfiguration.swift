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
    }
}
