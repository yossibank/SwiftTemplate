import DebugMenu
import Environment
import Rakuten
import RakutenView
import SwiftUI
import ViewComponent

public struct DebugRootView: View {
    @State private var isShowDebug = false

    public init() {}

    public var body: some View {
        RakutenView(viewModel: RakutenViewModel.make())
            .onShake {
                isShowDebug.toggle()
            }
            .sheet(isPresented: $isShowDebug) {
                DebugView(
                    dataModel: .init(
                        appVersion: AppEnvironment.version
                    )
                )
            }
    }
}
