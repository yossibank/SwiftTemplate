import Foundation

@MainActor
public protocol ViewResolver {
    func resolveConcrete(
        _ descriptor: ViewDescriptor.RakutenDescriptor
    ) -> ViewDescriptor.RakutenDescriptor.Output
}
