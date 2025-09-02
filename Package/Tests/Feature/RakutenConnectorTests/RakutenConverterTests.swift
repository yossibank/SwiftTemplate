@testable import Rakuten
@testable import RakutenConnector
@testable import RakutenView
import Testing

actor RakutenConverterTests {
    private let converter = RakutenConverter()

    @Test("RakutenModel → RakutenViewItemに変換できること")
    func convert() {
        // arrange
        let expected = RakutenViewItem(
            items: [
                .init(
                    id: "1",
                    name: "title1",
                    price: "10,000円",
                    imageURL: .init(string: "https://sample.com/imageURL1")
                )
            ],
            totalCount: 100,
            currentPage: 1,
            maxPage: 10
        )

        let model = RakutenModel(
            items: [
                .init(
                    id: "1",
                    name: "title1",
                    description: "description1",
                    price: 10000,
                    imageURL: .init(string: "https://sample.com/imageURL1"),
                    imageURLs: [],
                    itemURL: nil
                )
            ],
            totalCount: 100,
            currentPage: 1,
            maxPage: 10
        )

        // act
        let actaul = converter.convert(model)

        // assert
        #expect(actaul == expected)
    }
}
