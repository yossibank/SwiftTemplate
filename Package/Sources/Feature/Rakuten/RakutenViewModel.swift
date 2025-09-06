import AppFoundation
import FirebaseLive
import Foundation
import RakutenView

@Observable
public final class RakutenViewModel {
    public struct Dependency: Sendable {
        let useCase: any RakutenUseCaseProtocol
        let converter: any RakutenConverterProtocol
        let analytics: any FirebaseAnalyzable
    }

    private let dependency: Dependency

    public static func make() -> RakutenViewModel {
        RakutenViewModel(
            dependency: .init(
                useCase: RakutenUseCase.make(),
                converter: RakutenConverter(),
                analytics: FirebaseAnalytics(screenID: .search)
            )
        )
    }

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    private var isFetching: Bool {
        if case .initialLoading = viewState {
            return true
        }

        if case .additionalLoading = viewState {
            return true
        }

        return false
    }

    // MARK: - Output

    public var viewState: AppPagingState<RakutenViewItem.Item> = .initial
    public var loadedItems = [RakutenViewItem.Item]()
    public var parameter = RakutenViewItem.Parameter()

    // MARK: - Input

    public func search(isInitial: Bool = true) async {
        if isInitial {
            viewState = .initialLoading
            resetItems()
        } else {
            viewState = .additionalLoading
        }

        // event

        do {
            let model = try await dependency.useCase.search(
                keyword: parameter.keyword,
                page: parameter.nextPage
            )

            updateItems(dependency.converter.convert(model))
        } catch let appError as AppError {
            if isInitial {
                viewState = .initialError(appError)
            } else {
                viewState = .additionalError(appError)
            }
        } catch {}
    }

    public func additionalLoading(_ item: RakutenViewItem.Item) async {
        guard
            loadedItems.last?.id == item.id,
            !parameter.isPageEnd,
            !isFetching
        else {
            return
        }

        await search(isInitial: false)
    }
}

private extension RakutenViewModel {
    func resetItems() {
        loadedItems = []
        parameter.nextPage = 1
        parameter.maxPage = 1
    }

    func updateItems(_ viewItem: RakutenViewItem) {
        parameter.nextPage = viewItem.currentPage + 1
        parameter.maxPage = viewItem.maxPage
        loadedItems.append(contentsOf: viewItem.items)
        viewState = .loaded(loaded: loadedItems)
    }
}

extension RakutenViewModel: RakutenViewModelProtocol {
    @ObservationIgnored
    public var inputs: any RakutenViewInput { self }

    @ObservationIgnored
    public var outputs: any RakutenViewOutput { self }

    @ObservationIgnored
    public var binding: any RakutenViewBinding {
        get { self }
        set {}
    }
}

extension RakutenViewModel: RakutenViewInput, RakutenViewOutput, RakutenViewBinding {}
