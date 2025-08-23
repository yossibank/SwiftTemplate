import AppConfiguration
import AppDebug
import AppFeature
import AppUI
import SwiftData
import SwiftUI

@main
struct SwiftTemplateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State private var isShowDebug = false

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

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
        .modelContainer(sharedModelContainer)
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        BuildConfiguration.setup()
        Logger.info(message: "【Environment】\(AppBuild.value)")
        return true
    }
}
