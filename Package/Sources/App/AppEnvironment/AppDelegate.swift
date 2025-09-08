import AppFoundation
import DebugMenu
import FirebaseLive
import SwiftUI
import UIKit

public final class AppDelegate: NSObject, UIApplicationDelegate {
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        setup()
        sendLog()
        sendEvent()
        return true
    }

    private func setup() {
        AppInitializer.setup()
        FirebaseConfiguration.setup()
    }

    private func sendLog() {
        Logger.info(message: "【Environment】\(AppConfiguration.value)")
    }

    private func sendEvent() {
        let date = DateConverter().dateToString(
            .now,
            format: .yyyyMdJp
        )

        FirebaseAnalytics(screenID: .boot).sendEvent(.boot(date: date))
    }
}

@MainActor
public extension WindowGroup {
    func debugContainer() -> some Scene {
        modelContainer(DebugMenuDataContainer.container)
    }
}
