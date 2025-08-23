import SwiftUI

struct BugReportView: View {
    private let router = Router()

    var body: some View {
        RouterView(router: router) {
            Text("BugReport")
                .navigationTitle("バグ報告")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BugReportView()
}
