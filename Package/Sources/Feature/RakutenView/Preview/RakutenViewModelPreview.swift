import AppFoundation
import SwiftUI

@Observable
public final class RakutenViewModelPreview {
    // MARK: - Output

    public var viewState: AppPagingState<RakutenViewItem.Item> = .loaded(
        loaded: [
            .init(id: "1", name: "テスト商品A", price: "1200", imageURL: nil),
            .init(id: "2", name: "テスト商品B", price: "2400", imageURL: nil),
            .init(id: "3", name: "テスト商品C", price: "3600", imageURL: nil)
        ]
    )

    public var loadedItems: [RakutenViewItem.Item] = [
        .init(id: "1", name: "テスト商品A", price: "1200", imageURL: nil),
        .init(id: "2", name: "テスト商品B", price: "2400", imageURL: nil),
        .init(id: "3", name: "テスト商品C", price: "3600", imageURL: nil)
    ]

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
