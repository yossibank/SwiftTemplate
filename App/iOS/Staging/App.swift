import Environment
import StagingApp
import SwiftUI

@main
struct SwiftTemplateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            StagingRootView()
        }
        .debugContainer()
    }
}
