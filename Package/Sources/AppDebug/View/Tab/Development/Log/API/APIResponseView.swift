import AppExtension
import AppFeature
import AppUI
import SwiftUI
import ViewComponent

struct APIResponseView: View {
    @State private var nowDate = Date.now

    private let dateConverter = DateConverter(.jp)

    let model: APIModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Text(dateConverter.dateToString(model.date, format: .mmddEHHmmssSSS))
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .lineLimit(1)

                Text("Networking")
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .padding(.vertical, 1)
                    .padding(.horizontal, 4)
                    .background(.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .lineLimit(1)

                Spacer()

                Text(dateConverter.timeDifference(nowDate, targetDate: model.date))
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            Task { @MainActor in
                                nowDate = .now
                            }
                        }
                    }
            }

            HStack(alignment: .center, spacing: 8) {
                NetworkHTTPMethodView(httpMethod: model.httpMethod)
                    .bold()

                Text(model.path ?? "取得失敗")
                    .opacity(0.7)
                    .font(.subheadline)
                    .bold()
            }

            HStack {
                if let contentType = model.requestHeaders?["Content-Type"],
                   let value = contentType {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🔔Content-Type")
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(.gray)

                        Text(value)
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(.gray)
                            .lineLimit(1)
                    }
                }

                Spacer()

                NetworkStatusCodeView(statusCode: model.statusCode)
            }

            if !model.queryItems.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("💡QueryItems")
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.gray)

                    NetworkDictionaryView(dictionaries: model.queryItems)
                }
            }

            if let errorDescription = model.errorDescription {
                Text(errorDescription)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ContainerViewPreview(container: AppDebugDataContainer.container) {
        APIResponseView(model: .mock)
            .padding()
    }
}
