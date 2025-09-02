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
        let value = Bundle.main.object(
            forInfoDictionaryKey: "AppConfiguration"
        ) as! String

        AppBuild.value = .init(value: value.toInt)
    }
}
