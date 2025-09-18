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

    public struct Parameter {
        public var keyword: String
        public var nextPage: Int
        public var maxPage: Int

        public var isPageEnd: Bool {
            nextPage > maxPage
        }

        public init(
            keyword: String = "",
            nextPage: Int = 1,
            maxPage: Int = 1
        ) {
            self.keyword = keyword
            self.nextPage = nextPage
            self.maxPage = maxPage
        }
    }
}
