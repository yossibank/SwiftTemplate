import AppConfiguration

enum BuildConfiguration {
    static func setup() {
        let value: AppBuild = {
            #if DEV
                .dev
            #elseif ADHOC
                .adHoc
            #else
                .release
            #endif
        }()

        AppBuild.value = value
    }
}
