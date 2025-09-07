import BuilderMacro
import Foundation

@Builder
public struct RakutenViewItem: Hashable, Sendable {
    public let items: [Item]
    public let totalCount: Int
    public let currentPage: Int
    public let maxPage: Int

    @Builder
    public struct Item: Hashable, Sendable {
        public let id: String
        public let name: String
        public let price: String
        public let imageURL: URL?

        public init(
            id: String,
            name: String,
            price: String,
            imageURL: URL?
        ) {
            self.id = id
            self.name = name
            self.price = price
            self.imageURL = imageURL
        }
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

    public init(
        items: [Item],
        totalCount: Int,
        currentPage: Int,
        maxPage: Int
    ) {
        self.items = items
        self.totalCount = totalCount
        self.currentPage = currentPage
        self.maxPage = maxPage
    }
}
