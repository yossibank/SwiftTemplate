import SwiftUI

public struct ViewDescriptor {}

public extension ViewDescriptor {
    struct RakutenDescriptor: TypedDescriptor {
        public typealias Output = AnyView

        public init() {}
    }

    struct RakutenDetailDescriptor: TypedDescriptor {
        public typealias Output = AnyView

        public let title: String

        public init(title: String) {
            self.title = title
        }
    }
}
