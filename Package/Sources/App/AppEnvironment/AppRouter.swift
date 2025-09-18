import AutoInitMacro
import SwiftUI
import ViewEnvironment

@AutoInit
@MainActor
public final class AppRouter {
    private let environment: any ViewEnvironment

    public func rootView() -> some View {
        let descriptor = ViewDescriptor.RakutenDescriptor()
        let view = environment.resolve(descriptor)
        return view
    }
}
