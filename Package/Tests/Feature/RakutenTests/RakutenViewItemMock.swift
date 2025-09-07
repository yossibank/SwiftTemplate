import BuilderMacro
@testable import RakutenView

enum RakutenViewItemMock {
    static let testData = RakutenViewItem.makeTestBuilder()
        .items([RakutenViewItemItemMock.testData])
        .totalCount(1)
        .currentPage(1)
        .maxPage(1)
        .build()
}

enum RakutenViewItemItemMock {
    static let testData = RakutenViewItem.Item.makeTestBuilder()
        .id("itemCode1")
        .name("name1")
        .price("12,345円")
        .imageURL(.init(string: "https://test.com/medium"))
        .build()
}
