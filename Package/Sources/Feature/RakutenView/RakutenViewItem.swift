import AutoInitMacro
import BuilderMacro
import Foundation

@AutoInit
@Builder
public struct RakutenViewItem: Hashable, Sendable {
    public let items: [Item]
    public let totalCount: Int
    public let currentPage: Int
    public let maxPage: Int

    @AutoInit
    @Builder
    public struct Item: Hashable, Sendable {
        public let id: String
        public let name: String
        public let price: String
        public let imageURL: URL?
    }

    @AutoInit
    @Builder
    public struct Parameter: Sendable {
        @Init(default: "") public var keyword: String
        @Init(default: 1) public var nextPage: Int
        @Init(default: 1) public var maxPage: Int

        public var isPageEnd: Bool {
            nextPage > maxPage
        }

        public static let preview = Parameter
            .makeTestBuilder()
            .keyword("テスト")
            .build()
    }
}
