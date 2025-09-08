import Foundation

public protocol ViewEnvironment {
    func resolve<Descriptor: TypedDescriptor>(
        _ descriptor: Descriptor
    ) -> Descriptor.Output
}
