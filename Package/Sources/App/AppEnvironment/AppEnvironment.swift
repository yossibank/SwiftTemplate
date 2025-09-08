import Rakuten
import RakutenView
import SwiftUI
import ViewEnvironment

@MainActor
public struct AppEnvironment {
    public init() {}
}

public extension AppEnvironment {
    func resolve<Descriptor: TypedDescriptor>(
        _ descriptor: Descriptor
    ) -> Descriptor.Output {
        switch descriptor {
        case let rakutenDescriptor as ViewDescriptor.RakutenDescriptor:
            resolveConcrete(rakutenDescriptor) as! Descriptor.Output
        default:
            fatalError("Unknown descriptor")
        }
    }
}

extension AppEnvironment: ViewResolver {
    public func resolveConcrete(
        _ descriptor: ViewDescriptor.RakutenDescriptor
    ) -> ViewDescriptor.RakutenDescriptor.Output {
        AnyView(RakutenView(viewModel: RakutenViewModel.make()))
    }
}
