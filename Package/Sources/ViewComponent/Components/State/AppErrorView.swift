import AppExtension
import SwiftUI

public struct AppErrorView: View {
    private let message: String?
    private let didTapReloadButton: VoidBlock

    public init(
        message: String?,
        didTapReloadButton: @escaping VoidBlock
    ) {
        self.message = message
        self.didTapReloadButton = didTapReloadButton
    }

    public var body: some View {
        VStack(spacing: 24) {
            Image(.information)
                .resizable()
                .frame(width: 160, height: 160)

            Text("エラーが発生しました")
                .font(.headline)
                .foregroundStyle(.red)

            VStack(spacing: 8) {
                Text("原因")
                    .font(.subheadline)
                    .bold()

                Text(message ?? "原因不明")
                    .font(.subheadline)
                    .bold()
            }
            .padding(16)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.red, lineWidth: 2.0)
            }

            Button {
                didTapReloadButton()
            } label: {
                Text("リロードする")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.red)
                    .padding(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.red, lineWidth: 2.0)
                    }
            }
        }
    }
}

#Preview {
    AppErrorView(message: "なんらかのエラーです") {}
}
