import AppFoundation
import SwiftUI

struct DevelopmentView: View {
    let dataModel: DebugMenuDataModel

    private let router = Router()

    var body: some View {
        RouterView(router: router) {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("開発環境")
                            .bold()
                            .font(.caption2)

                        Text(AppConfiguration.value.title)
                            .bold()
                            .font(.subheadline)
                    }

                    VStack(alignment: .leading) {
                        Text("アプリバージョン")
                            .bold()
                            .font(.caption2)

                        Text(dataModel.appVersion)
                            .bold()
                            .font(.subheadline)
                    }
                }

                Section {
                    NavigationLink(value: Route.log(.app)) {
                        Text("アプリログ")
                            .bold()
                            .font(.subheadline)
                    }

                    NavigationLink(value: Route.log(.api(.list))) {
                        Text("APIログ")
                            .bold()
                            .font(.subheadline)
                    }
                } header: {
                    Text("アプリログ履歴")
                        .bold()
                        .font(.caption)
                        .foregroundStyle(.black)
                }
            }
            .scrollContentBackground(.hidden)
            .background(.gray.opacity(0.12))
            .listStyle(.insetGrouped)
            .navigationTitle("開発メニュー")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DevelopmentView(dataModel: .init(appVersion: "1.0.0"))
        .modelContainer(DebugMenuDataContainer.previewContainer)
}
