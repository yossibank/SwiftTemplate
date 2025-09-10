import SwiftUI

@MainActor
public struct PreviewEnvironment {
    public init() {}
}

extension PreviewEnvironment: ViewEnvironment {
    public func resolve<Descriptor: TypedDescriptor>(
        _ descriptor: Descriptor
    ) -> Descriptor.Output {
        AnyView(Text("画面遷移(プレビュー用)")) as! Descriptor.Output
    }
}
