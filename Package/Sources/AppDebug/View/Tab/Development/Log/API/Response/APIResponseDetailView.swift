import AppUI
import SwiftUI
import ViewComponent

struct APIResponseBodyView: View {
    let model: APIModel
    let mode: APIResponseBodyMode

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Text("Size")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Text(model.responseSize ?? "???")
                        .font(.callout)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)

                Divider()

                switch mode {
                case .response:
                    JSONView(model.responseBody.unwrapped)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)

                case .request:
                    JSONView(model.httpBody.unwrapped)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ContainerViewPreview(container: AppDebugDataContainer.container) {
        APIResponseBodyView(
            model: .mock,
            mode: .request
        )
    }
}
