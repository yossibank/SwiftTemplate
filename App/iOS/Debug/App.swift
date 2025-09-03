import DebugApp
import Environment
import SwiftUI

@main
struct SwiftTemplateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            DebugRootView()
        }
        .debugContainer()
    }
}
