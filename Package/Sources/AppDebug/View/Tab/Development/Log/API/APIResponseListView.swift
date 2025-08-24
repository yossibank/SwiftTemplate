import SwiftData
import SwiftUI

struct APIResponseListView: View {
    @Query(
        sort: \APIModel.date,
        order: .reverse
    )
    private var models: [APIModel]

    @Environment(\.modelContext) private var context

    var body: some View {
        List(models, id: \.id) { model in
            NavigationLink(value: Route.log(.api(.detail(model)))) {
                APIResponseView(model: model)
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    RouterView(router: Router()) {
        APIResponseListView()
            .modelContainer(AppDebugDataContainer.previewContainer)
    }
}
