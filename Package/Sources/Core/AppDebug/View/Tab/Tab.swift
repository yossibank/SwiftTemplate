import SwiftUI

struct TabItem: Hashable {
    let title: String
    let systemName: String
    let tab: Tab

    enum Tab: CaseIterable {
        case development
        case bugReport
        case checklist
    }
}

extension TabItem {
    static let development = TabItem(
        title: "お助け開発ツール",
        systemName: "apple.terminal",
        tab: .development
    )

    static let bugReport = TabItem(
        title: "バグ報告",
        systemName: "popcorn",
        tab: .bugReport
    )

    static let checklist = TabItem(
        title: "チェックリスト",
        systemName: "checklist",
        tab: .checklist
    )
}

extension View {
    @ViewBuilder
    func tabItem(_ item: TabItem) -> some View {
        tabItem {
            Label(item.title, systemImage: item.systemName)
        }
        .tag(item.tab)
    }
}
