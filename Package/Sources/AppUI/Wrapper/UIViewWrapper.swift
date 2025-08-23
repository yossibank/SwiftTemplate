import SwiftUI
import UIKit

public struct UIViewWrapper<View: UIView> {
    public let view: View

    public var configuration: ((View) -> Void)?

    public init(
        view: View,
        configuration: ((View) -> Void)? = nil
    ) {
        self.view = view
        self.configuration = configuration
    }
}

extension UIViewWrapper: UIViewRepresentable {
    public func makeUIView(context: Context) -> View {
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {
        configuration?(uiView)
    }
}
