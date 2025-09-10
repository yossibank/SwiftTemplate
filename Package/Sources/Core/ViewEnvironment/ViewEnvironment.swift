import Foundation

@MainActor
public protocol ViewEnvironment: Sendable {
    func resolve<Descriptor: TypedDescriptor>(
        _ descriptor: Descriptor
    ) -> Descriptor.Output
}
