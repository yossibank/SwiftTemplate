import AppFoundation
import SwiftUI
import ViewEnvironment

@Observable
public final class RakutenViewModelPreview {
    public init(
        viewState: AppPagingState<RakutenViewItem.Item> = .initial,
        parameter: RakutenViewItem.Parameter = .init()
    ) {
        self.viewState = viewState
        self.parameter = parameter
    }

    // MARK: - Output

    public var viewState: AppPagingState<RakutenViewItem.Item>
    public var loadedItems: [RakutenViewItem.Item] = RakutenViewItem.preview
    public var parameter = RakutenViewItem.Parameter()

    // MARK: - Input

    public func search(isInitial: Bool = true) async {}
    public func additionalLoading(_ item: RakutenViewItem.Item) async {}
}

extension RakutenViewModelPreview: RakutenViewModelProtocol {
    @ObservationIgnored
    public var inputs: any RakutenViewInput { self }

    @ObservationIgnored
    public var outputs: any RakutenViewOutput { self }

    @ObservationIgnored
    public var binding: any RakutenViewBinding {
        get { self }
        set {}
    }

    public var router: RakutenRouter {
        .init(environment: PreviewEnvironment())
    }
}

extension RakutenViewModelPreview: RakutenViewInput, RakutenViewOutput, RakutenViewBinding {}
