import DebugMenu
import Environment
import Rakuten
import RakutenView
import SwiftUI

public struct StagingRootView: View {
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
