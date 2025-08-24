import AppExtension
import AppFeature
import AppUI
import SwiftUI
import ViewComponent

struct APIResponseDetailView: View {
    @State private var nowDate = Date.now

    private let dateConverter = DateConverter(.jp)

    let model: APIModel

    var body: some View {
        List {
            timeSectionView
            responseSectionView
            requestSectionView
        }
    }

    private var timeSectionView: some View {
        Section {
            HStack(spacing: 8) {
                Text(dateConverter.dateToString(model.date, format: .mmddEHHmmssSSS))
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(1)

                Text("Networking")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(.vertical, 1)
                    .padding(.horizontal, 4)
                    .background(.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .lineLimit(1)

                Spacer()

                Text(dateConverter.timeDifference(nowDate, targetDate: model.date))
                    .font(.caption)
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
        }
    }

    private var responseSectionView: some View {
        Section {
            HStack {
                Text("Status Code")
                    .font(.caption)
                    .foregroundStyle(.gray)

                NetworkStatusCodeView(statusCode: model.statusCode)
            }

            if let responseBody = model.responseBody {
                NavigationLink(value: Route.log(.api(.body(model, .response)))) {
                    HStack {
                        Text("Body")
                            .font(.caption)
                            .foregroundStyle(.gray)

                        Text(responseBody)
                            .font(.caption)
                            .lineLimit(2)
                    }
                }
            }

            if let errorLocalizedDescription = model.errorLocalizedDescription {
                HStack {
                    Text("Error")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Text(errorLocalizedDescription)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.red)
                }
            }

            if let headers = model.responseHeaders,
               !headers.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Headers")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    NetworkDictionaryView(dictionaries: headers)
                }
            }
        } header: {
            Text("Response")
                .foregroundStyle(.black)
                .bold()
        }
        .textCase(nil)
    }

    private var requestSectionView: some View {
        Section {
            HStack {
                Text("Method")
                    .font(.caption)
                    .foregroundStyle(.gray)

                NetworkHTTPMethodView(httpMethod: model.httpMethod)
            }

            HStack {
                Text("Host")
                    .font(.caption)
                    .foregroundStyle(.gray)

                Text(model.host ?? "???")
                    .font(.footnote)
                    .bold()
            }

            HStack {
                Text("Path")
                    .font(.caption)
                    .foregroundStyle(.gray)

                Text(model.path ?? "???")
                    .font(.footnote)
                    .bold()
            }

            if let httpBody = model.httpBody {
                NavigationLink(value: Route.log(.api(.body(model, .request)))) {
                    HStack {
                        Text("Body")
                            .font(.caption)
                            .foregroundStyle(.gray)

                        Text(httpBody)
                            .font(.caption)
                            .lineLimit(2)
                    }
                }
            }

            if !model.queryItems.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Query Parameters")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    NetworkDictionaryView(dictionaries: model.queryItems)
                }
            }

            if let headers = model.requestHeaders,
               !headers.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Headers")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    NetworkDictionaryView(dictionaries: headers)
                }
            }
        } header: {
            Text("Request")
                .foregroundStyle(.black)
                .bold()
        }
        .textCase(nil)
    }
}

#Preview {
    ContainerViewPreview(container: AppDebugDataContainer.container) {
        RouterView(router: Router()) {
            APIResponseDetailView(model: .mock)
        }
    }
}
