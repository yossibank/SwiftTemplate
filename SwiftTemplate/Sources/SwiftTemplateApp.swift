import AppConfiguration
import AppDebug
import AppFeature
import AppFirebase
import AppUI
import SwiftData
import SwiftUI

@main
struct SwiftTemplateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State private var isShowDebug = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onShake {
                    isShowDebug.toggle()
                }
                .sheet(isPresented: $isShowDebug) {
                    DebugView(
                        dataModel: .init(
                            appVersion: BuildConfiguration.version
                        )
                    )
                }
        }
        .debugContainer()
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        setup()
        sendLog()
        sendEvent()
        return true
    }

    private func setup() {
        BuildConfiguration.setup()
        FirebaseConfiguration.setup()
    }

    private func sendLog() {
        Logger.info(message: "【Environment】\(AppBuild.value)")
    }

    private func sendEvent() {
        let date = DateConverter().dateToString(
            .now,
            format: .yyyyMdJp
        )

        FirebaseAnalytics(screenID: .boot).sendEvent(.boot(date: date))
    }
}

private extension Scene {
    func debugContainer() -> some Scene {
        #if DEBUG
            modelContainer(AppDebugDataContainer.container)
        #else
            self
        #endif
    }
}
