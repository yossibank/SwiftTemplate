import SwiftUI

public struct DebugView: View {
    private let dataModel: AppDebugDataModel

    public init(dataModel: AppDebugDataModel) {
        self.dataModel = dataModel
    }

    public var body: some View {
        TabView {
            DevelopmentView(dataModel: dataModel)
                .tabItem(.development)

            BugReportView()
                .tabItem(.bugReport)

            ChecklistView()
                .tabItem(.checklist)
        }
    }
}

#Preview {
    DebugView(dataModel: .init(appVersion: "1.0.0"))
}
