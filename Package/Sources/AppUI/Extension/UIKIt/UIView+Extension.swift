import UIKit

public extension UIView {
    func removeSubview<T: UIView>(ofType type: T.Type) {
        for subview in subviews {
            if let subview = subview as? T {
                subview.removeFromSuperview()
            }
        }
    }

    func removeAllSubview() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
