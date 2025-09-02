import SwiftUI

public struct ToastView: View {
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

    public var body: some View {
        HStack(spacing: 16) {
            toast.image
                .resizable()
                .scaledToFit()
                .frame(height: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(toast.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)

                if let message {
                    Text(message)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 28)
        .background(toast.style)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            withAnimation {
                isShown = false
            }
        }
        .onAppear {
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(3))

                withAnimation {
                    isShown = false
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ToastView(
            isShown: .constant(true),
            toast: .done,
            message: "タスク完了"
        )

        ToastView(
            isShown: .constant(true),
            toast: .warning,
            message: "タスク警告"
        )

        ToastView(
            isShown: .constant(true),
            toast: .error,
            message: "タスクエラー"
        )
    }
}
