import SwiftUI

struct ChecklistView: View {
    private let router = Router()

    var body: some View {
        RouterView(router: router) {
            Text("Checklist")
                .navigationTitle("チェックリスト")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ChecklistView()
}
