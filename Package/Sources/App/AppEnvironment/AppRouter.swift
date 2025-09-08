import SwiftUI
import ViewEnvironment

@MainActor
public final class AppRouter {
    public var rootView: some View {
        resolver.resolveConcrete(ViewDescriptor.RakutenDescriptor())
    }

    private let resolver: any ViewResolver

    public init(resolver: any ViewResolver) {
        self.resolver = resolver
    }
}
