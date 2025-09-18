import AutoInitMacro
import SwiftUI

public struct ViewDescriptor {}

public extension ViewDescriptor {
    @AutoInit
    struct RakutenDescriptor: TypedDescriptor {
        public typealias Output = AnyView
    }

    @AutoInit
    struct RakutenDetailDescriptor: TypedDescriptor {
        public typealias Output = AnyView

        public let title: String
    }
}
