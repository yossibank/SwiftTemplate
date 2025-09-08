import BuilderMacro
@testable import Rakuten

extension RakutenEntity {
    static let testData = RakutenEntity.makeTestBuilder()
        .items(
            [
                RakutenEntity.RakutenItem.makeTestBuilder()
                    .itemName("name1")
                    .catchcopy("catchcopy1")
                    .itemCode("itemCode1")
                    .itemPrice(12345)
                    .itemCaption("description1")
                    .itemUrl("https://test.com")
                    .smallImageUrls(["https://test.com/small"])
                    .mediumImageUrls(["https://test.com/medium"])
                    .build()
            ]
        )
        .count(1)
        .page(1)
        .first(1)
        .last(1)
        .hits(1)
        .carrier(1)
        .pageCount(1)
        .build()
}
