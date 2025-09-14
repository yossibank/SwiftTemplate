// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import ViewEnvironment

@MainActor
public struct AppEnvironment {
    public init() {}
}

extension AppEnvironment: ViewEnvironment {
    public func resolve<Descriptor: TypedDescriptor>(
        _ descriptor: Descriptor
    ) -> Descriptor.Output {
        switch descriptor {
        case let rakutenDescriptor as ViewDescriptor.RakutenDescriptor:
            resolveConcrete(rakutenDescriptor) as! Descriptor.Output
        case let rakutenDetailDescriptor as ViewDescriptor.RakutenDetailDescriptor:
            resolveConcrete(rakutenDetailDescriptor) as! Descriptor.Output
        default:
            fatalError("Unknown descriptor")
        }
    }
}

extension AppEnvironment: ViewResolver {
    public func resolveConcrete(
        _ descriptor: ViewDescriptor.RakutenDescriptor
    ) -> ViewDescriptor.RakutenDescriptor.Output {
        AppViewBuilder.build(with: descriptor, environment: self)
    }

    public func resolveConcrete(
        _ descriptor: ViewDescriptor.RakutenDetailDescriptor
    ) -> ViewDescriptor.RakutenDetailDescriptor.Output {
        AppViewBuilder.build(with: descriptor, environment: self)
    }
}
