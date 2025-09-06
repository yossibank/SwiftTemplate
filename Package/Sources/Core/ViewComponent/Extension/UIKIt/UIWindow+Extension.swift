import UIKit

public extension UIWindow {
    static var connectedWindowScene: UIWindowScene? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first
    }

    static var keyWindow: UIWindow? {
        connectedWindowScene?.windows
            .filter(\.isKeyWindow)
            .first
    }
}
