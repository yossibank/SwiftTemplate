import SwiftUI

public struct AppLoadingView: View {
    public enum Loading {
        case circle
        case dots
        case particle
    }

    private let loading: Loading

    public init(_ loading: Loading = .dots) {
        self.loading = loading
    }

    public var body: some View {
        switch loading {
        case .circle:
            LoadingCircleView()

        case .dots:
            LoadingDotsView()

        case .particle:
            LoadingParticleView()
        }
    }
}

#Preview {
    VStack(spacing: 64) {
        AppLoadingView(.circle)
            .frame(width: 50, height: 50)

        AppLoadingView(.dots)
            .frame(width: 50, height: 50)

        AppLoadingView(.particle)
            .frame(width: 50, height: 50)
    }
}
