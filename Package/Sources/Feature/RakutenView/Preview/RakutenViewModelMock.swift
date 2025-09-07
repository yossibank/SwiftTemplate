import AppFoundation
import SwiftUI

@Observable
public final class RakutenViewModelMock {
    // MARK: - Output

    public var viewState: AppPagingState<RakutenViewItem.Item> = .loaded(
        loaded: [
            .makeTestBuilder()
                .id("1")
                .name("テスト商品A")
                .price("1,200円")
                .imageURL(URL(string: "https://picsum.photos/200"))
                .build(),
            .makeTestBuilder()
                .id("2")
                .name("テスト商品B")
                .price("12,200円")
                .imageURL(URL(string: "https://picsum.photos/200"))
                .build(),
            .makeTestBuilder()
                .id("3")
                .name("テスト商品C")
                .price("3,900円")
                .imageURL(URL(string: "https://picsum.photos/200"))
                .build()
        ]
    )

    public var loadedItems: [RakutenViewItem.Item] = [
        .makeTestBuilder()
            .id("1")
            .name("テスト商品A")
            .price("1,200円")
            .imageURL(URL(string: "https://picsum.photos/200"))
            .build(),
        .makeTestBuilder()
            .id("2")
            .name("テスト商品B")
            .price("12,200円")
            .imageURL(URL(string: "https://picsum.photos/200"))
            .build(),
        .makeTestBuilder()
            .id("3")
            .name("テスト商品C")
            .price("3,900円")
            .imageURL(URL(string: "https://picsum.photos/200"))
            .build()
    ]

    public var parameter = RakutenViewItem.Parameter(keyword: "テスト検索")

    // MARK: - Input

    public func search(isInitial: Bool = true) async {}
    public func additionalLoading(_ item: RakutenViewItem.Item) async {}
}

extension RakutenViewModelMock: RakutenViewModelProtocol {
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

extension RakutenViewModelMock: RakutenViewInput, RakutenViewOutput, RakutenViewBinding {}
