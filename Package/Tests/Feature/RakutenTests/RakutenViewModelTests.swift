import AppFoundation
@testable import Mockolo
@testable import Rakuten
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
        let viewItems = [RakutenViewItem.Item.mock]

        useCase.searchHandler = { _, _ in
            RakutenModel.mock
        }

        converter.convertHandler = { _ in
            RakutenViewItem.makeTestBuilder()
                .items(viewItems)
                .totalCount(1)
                .currentPage(1)
                .maxPage(1)
                .build()
        }

        // act
        await viewModel.search()

        // assert
        #expect(viewModel.outputs.loadedItems == viewItems)
        #expect(viewModel.outputs.viewState == .loaded(items: viewItems))
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
