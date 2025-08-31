import AppFeature
@testable import Mockolo
@testable import Rakuten
@testable import RakutenConnector
@testable import RakutenView
import Testing

@MainActor
struct RakutenViewModelTests {
    private let useCase = RakutenUseCaseProtocolMock()
    private let converter = RakutenConverterProtocolMock()
    private let analytics = FirebaseAnalyzableMock()
    private let viewModel: RakutenViewModel

    init() {
        self.viewModel = .init(
            dependency: .init(
                useCase: useCase,
                converter: converter,
                analytics: analytics
            )
        )
    }

    @Test("検索できること(成功)")
    func searchSuccess() async {
        // arrange
        let viewItems = [
            RakutenViewItem.Item(
                id: "1",
                name: "title1",
                price: "1,000円",
                imageURL: nil
            )
        ]

        useCase.searchHandler = { _, _ in
            RakutenModel(
                items: [
                    .init(
                        id: "1",
                        name: "ittle1",
                        description: "description1",
                        price: 1000,
                        imageURL: nil,
                        imageURLs: [],
                        itemURL: nil
                    )
                ],
                totalCount: 100,
                currentPage: 1,
                maxPage: 10
            )
        }

        converter.convertHandler = { _ in
            RakutenViewItem(
                items: viewItems,
                totalCount: 100,
                currentPage: 1,
                maxPage: 10
            )
        }

        // act
        await viewModel.search()

        // assert
        #expect(viewModel.outputs.loadedItems == viewItems)
        #expect(viewModel.outputs.viewState == .loaded(loaded: viewItems))
    }

    @Test("検索できること(失敗)")
    func searchFailure() async {
        // arrange
        let appError = AppError.timeout

        useCase.searchHandler = { _, _ in
            throw appError
        }

        // act
        await viewModel.search()

        // assert
        #expect(viewModel.outputs.loadedItems.isEmpty)
        #expect(viewModel.outputs.viewState == .initialError(appError))
    }
}
