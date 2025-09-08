import AppFoundation
import Foundation

public enum AppInitializer {
    public static func setup() {
        let value = Bundle.main.object(
            forInfoDictionaryKey: "AppConfiguration"
        ) as! String

        AppConfiguration.value = .init(value: value.toInt)
    }
}
