import AutoInitMacro
import SwiftUI
import ViewEnvironment

@AutoInit
@MainActor
public final class RakutenRouter {
    private let environment: any ViewEnvironment

    public func detailView(_ title: String) -> some View {
        let descriptor = ViewDescriptor.RakutenDetailDescriptor(title: title)
        let view = environment.resolve(descriptor)
        return view
    }
}
