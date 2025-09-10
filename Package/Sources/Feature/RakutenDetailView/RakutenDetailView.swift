import SwiftUI

public struct RakutenDetailView: View {
    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        Text(title)
    }
}

#Preview {
    RakutenDetailView(title: "Title")
}
