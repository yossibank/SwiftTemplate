import AppFoundation
import SwiftUI

@Observable
public final class RakutenViewModelPreview {
    public init() {}

    // MARK: - Output

    public var viewState: AppPagingState<RakutenViewItem.Item> = .loaded(
        items: RakutenViewItem.preview
    )
    public var loadedItems: [RakutenViewItem.Item] = RakutenViewItem.preview
    public var parameter = RakutenViewItem.Parameter(keyword: "テスト検索")

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
}

extension RakutenViewModelPreview: RakutenViewInput, RakutenViewOutput, RakutenViewBinding {}
