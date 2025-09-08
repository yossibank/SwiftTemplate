import AppEnvironment
import ReleaseApp
import SwiftUI

@main
struct SwiftTemplateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ReleaseRootView()
        }
    }
}
