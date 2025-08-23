import SwiftUI

public struct ToastModifier: ViewModifier {
    @Binding private var isShown: Bool

    private let toast: Toast
    private let message: String?

    public init(
        isShown: Binding<Bool>,
        toast: Toast,
        message: String? = nil
    ) {
        self._isShown = isShown
        self.toast = toast
        self.message = message
    }

    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content

            if isShown {
                ToastView(
                    isShown: _isShown,
                    toast: toast,
                    message: message
                )
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

public extension View {
    func showToast(
        isShown: Binding<Bool>,
        toast: Toast,
        message: String? = nil
    ) -> some View {
        modifier(
            ToastModifier(
                isShown: isShown,
                toast: toast,
                message: message
            )
        )
    }
}
