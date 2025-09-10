import SwiftUI
import ViewEnvironment

@MainActor
public final class AppRouter {
    private let environment: any ViewEnvironment

    public init(environment: any ViewEnvironment) {
        self.environment = environment
    }

    public func rootView() -> some View {
        let descriptor = ViewDescriptor.RakutenDescriptor()
        let view = environment.resolve(descriptor)
        return view
    }
}
