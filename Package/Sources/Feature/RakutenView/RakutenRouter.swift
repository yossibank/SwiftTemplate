import SwiftUI
import ViewEnvironment

@MainActor
public final class RakutenRouter {
    private let environment: any ViewEnvironment

    public init(environment: any ViewEnvironment) {
        self.environment = environment
    }

    public func detailView(_ title: String) -> some View {
        let descriptor = ViewDescriptor.RakutenDetailDescriptor(title: title)
        let view = environment.resolve(descriptor)
        return view
    }
}
