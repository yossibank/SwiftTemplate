import Foundation

public protocol ObjectAppliable {}

public extension ObjectAppliable {
    @discardableResult
    func apply(_ configuration: (Self) -> Void) -> Self {
        configuration(self)
        return self
    }
}

extension NSObject: ObjectAppliable {}
