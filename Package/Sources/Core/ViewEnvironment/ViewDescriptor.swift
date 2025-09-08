import SwiftUI

public struct ViewDescriptor {}

public extension ViewDescriptor {
    struct RakutenDescriptor: TypedDescriptor {
        public typealias Output = AnyView
        public init() {}
    }
}
