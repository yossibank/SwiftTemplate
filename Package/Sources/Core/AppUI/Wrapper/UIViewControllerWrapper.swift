import SwiftUI
import UIKit

public struct UIViewControllerWrapper<ViewController: UIViewController> {
    public let viewController: ViewController

    public var configuration: ((ViewController) -> Void)?

    public init(
        viewController: ViewController,
        configuration: ((ViewController) -> Void)? = nil
    ) {
        self.viewController = viewController
        self.configuration = configuration
    }
}

extension UIViewControllerWrapper: UIViewControllerRepresentable {
    public func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    public func updateUIViewController(
        _ uiViewController: ViewController,
        context: Context
    ) {
        configuration?(uiViewController)
    }
}
