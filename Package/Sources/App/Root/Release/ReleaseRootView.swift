import AppEnvironment
import Rakuten
import RakutenView
import SwiftUI

public struct ReleaseRootView: View {
    private let appRouter = AppRouter(environment: AppEnvironment())

    public init() {}

    public var body: some View {
        appRouter.rootView()
    }
}
