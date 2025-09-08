import SwiftUI
import ViewEnvironment

@MainActor
public final class RakutenRouter {
    private let resolver: any ViewResolver

    public init(resolver: any ViewResolver) {
        self.resolver = resolver
    }
}
