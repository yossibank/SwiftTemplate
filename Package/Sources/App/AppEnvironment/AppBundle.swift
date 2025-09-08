import Foundation

public enum AppBundle {
    public static var version: String {
        guard let info = Bundle.main.infoDictionary else {
            return ""
        }

        return info["CFBundleShortVersionString"] as? String ?? "???"
    }
}
