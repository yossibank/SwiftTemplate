import AppConfiguration
import Foundation

enum BuildConfiguration {
    static var version: String {
        guard let info = Bundle.main.infoDictionary else {
            return ""
        }

        return info["CFBundleShortVersionString"] as? String ?? "???"
    }

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
