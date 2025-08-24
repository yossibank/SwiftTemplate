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
    private let date = DateConverter().dateToString(
        .now,
        format: .yyyyMdJp
    )

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        BuildConfiguration.setup()
        FirebaseConfiguration.setup()
        FirebaseAnalytics(screenID: .boot).sendEvent(.boot(date: date))
        Logger.info(message: "【Environment】\(AppBuild.value)")
        return true
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
