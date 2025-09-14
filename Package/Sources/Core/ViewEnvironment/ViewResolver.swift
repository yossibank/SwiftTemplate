// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation

@MainActor
public protocol ViewResolver {
    func resolveConcrete(
        _ descriptor: ViewDescriptor.RakutenDescriptor
    ) -> ViewDescriptor.RakutenDescriptor.Output

    func resolveConcrete(
        _ descriptor: ViewDescriptor.RakutenDetailDescriptor
    ) -> ViewDescriptor.RakutenDetailDescriptor.Output
}