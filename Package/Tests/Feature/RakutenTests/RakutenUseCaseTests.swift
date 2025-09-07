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
        let expected = RakutenModel.mock

        apiClient.requestHandler = { request in
            #expect(request is RakutenRequest)
            return RakutenEntity.mock
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
