import Rakuten
import RakutenView
import SwiftUI

public struct ReleaseRootView: View {
    public init() {}

    public var body: some View {
        RakutenView(viewModel: RakutenViewModel.make())
    }
}
