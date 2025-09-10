import AppEnvironment
import DebugMenu
import Rakuten
import RakutenView
import SwiftUI

public struct StagingRootView: View {
    @State private var isShowDebug = false

    private let appRouter = AppRouter(environment: AppEnvironment())

    public init() {}

    public var body: some View {
        appRouter.rootView()
            .onShake {
                isShowDebug.toggle()
            }
            .sheet(isPresented: $isShowDebug) {
                DebugView(
                    dataModel: .init(
                        appVersion: AppBundle.version
                    )
                )
            }
    }
}
