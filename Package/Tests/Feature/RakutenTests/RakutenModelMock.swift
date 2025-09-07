import BuilderMacro
@testable import Rakuten

enum RakutenModelMock {
    static let testData = RakutenModel.makeTestBuilder()
        .items(
            [
                RakutenModel.RakutenItem.makeTestBuilder()
                    .id("itemCode1")
                    .name("name1")
                    .description("description1")
                    .price(12345)
                    .imageURL(.init(string: "https://test.com/medium"))
                    .imageURLs([.init(string: "https://test.com/medium")!])
                    .itemURL(.init(string: "https://test.com"))
                    .build()
            ]
        )
        .totalCount(1)
        .currentPage(1)
        .maxPage(1)
        .build()
}
