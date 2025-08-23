import SwiftUI

struct DevelopmentView: View {
    let dataModel: AppDebugDataModel

    private let router = Router()

    var body: some View {
        RouterView(router: router) {
            List {
                Section {
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
                } header: {
                    Text("アプリログ履歴")
                        .bold()
                        .font(.caption)
                        .foregroundStyle(.black)
                }
            }
            .scrollContentBackground(.hidden)
            .background(.gray.opacity(0.25))
            .listStyle(.insetGrouped)
            .navigationTitle("開発メニュー")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DevelopmentView(dataModel: .init(appVersion: "1.0.0"))
}
