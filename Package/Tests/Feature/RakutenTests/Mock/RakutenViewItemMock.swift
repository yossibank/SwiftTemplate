@testable import RakutenView

extension RakutenViewItem {
    static let mock = RakutenViewItem.makeTestBuilder()
        .items([.mock])
        .totalCount(1)
        .currentPage(1)
        .maxPage(1)
        .build()
}

extension RakutenViewItem.Item {
    static let mock = RakutenViewItem.Item.makeTestBuilder()
        .id("itemCode1")
        .name("name1")
        .price("12,345円")
        .imageURL(.init(string: "https://test.com/medium"))
        .build()
}
