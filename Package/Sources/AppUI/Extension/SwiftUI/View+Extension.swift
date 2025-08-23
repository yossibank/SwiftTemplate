import SwiftUI

public extension View {
    func frame(
        proxy: GeometryProxy,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            width: proxy.size.width,
            height: proxy.size.height,
            alignment: alignment
        )
    }
}

public extension View {
    @ViewBuilder
    func jsonKey(_ key: String?) -> some View {
        if let key {
            HStack(alignment: .top, spacing: 0) {
                Text("\"\(key)\"")
                Text(": ")
                    .foregroundStyle(.gray)
                self
            }
        } else {
            self
        }
    }
}
