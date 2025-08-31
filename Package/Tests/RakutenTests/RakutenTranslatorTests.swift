@testable import Rakuten
import Testing

actor RakutenTranslatorTests {
    private let translator = RakutenTranslator()

    @Test("RakutenEntotu → RakutenModelに変換できること")
    func translate() {
        // arrange
        let entity = RakutenEntity(
            items: [
                .init(
                    itemName: "name1",
                    catchcopy: "description1",
                    itemCode: "itemCode1",
                    itemPrice: 12345,
                    itemCaption: "itemCaption1",
                    itemUrl: "https://test.com",
                    smallImageUrls: ["https://test.com/small"],
                    mediumImageUrls: ["https://test.com/medium"]
                )
            ],
            count: 1,
            page: 1,
            first: 1,
            last: 1,
            hits: 1,
            carrier: 1,
            pageCount: 1
        )

        let expected = RakutenModel(
            items: [
                .init(
                    id: "itemCode1",
                    name: "name1",
                    description: "itemCaption1",
                    price: 12345,
                    imageURL: .init(string: "https://test.com/medium"),
                    imageURLs: [.init(string: "https://test.com/medium")!],
                    itemURL: .init(string: "https://test.com")
                )
            ],
            totalCount: 1,
            currentPage: 1,
            maxPage: 1
        )

        // act
        let actual = translator.translate(entity)

        // assert
        #expect(actual == expected)
    }
}
