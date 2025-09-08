import RakutenView
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            RakutenView(viewModel: RakutenViewModelPreview())
        }
    }
}
