@testable import Mockolo
@testable import Rakuten
import Testing

struct RakutenUseCaseTests {
    private let apiClient = APIClientProtocolMock()
    private let translator = RakutenTranslatorProtocolMock()
    private let useCase: RakutenUseCase

    init() {
        self.useCase = .init(
            apiClient: apiClient,
            translator: translator
        )
    }

    @Test("検索結果が受け取れること")
    func search() async throws {
        // arrange
        let expected = RakutenModel(
            items: [
                .init(
                    id: "itemCode1",
                    name: "name1",
                    description: "description1",
                    price: 12345,
                    imageURL: .init(string: "https://test.com/medium"),
                    imageURLs: [],
                    itemURL: .init(string: "https://test.com")
                )
            ],
            totalCount: 1,
            currentPage: 1,
            maxPage: 1
        )

        apiClient.requestHandler = { request in
            #expect(request is RakutenRequest)

            return RakutenEntity(
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
        }

        translator.translateHandler = { _ in
            expected
        }

        // act
        let actual = try await useCase.search(keyword: "keyword", page: 1)

        // assert
        #expect(actual == expected)
    }
}
