import AppFoundation
import AutoInitMacro
import KotlinMultiplatformLibrary
import RakutenView

/// @mockable
public protocol RakutenConverterProtocol: Sendable {
    func convert(_ model: RakutenModel) -> RakutenViewItem
}

@AutoInit
public struct RakutenConverter: RakutenConverterProtocol {
    public func convert(_ model: RakutenModel) -> RakutenViewItem {
        RakutenViewItem(
            items: model.items.map {
                RakutenViewItem.Item(
                    id: $0.id,
                    name: $0.name,
                    price: ValueFormatter(
                        value: .init(value: $0.price),
                        style: .init(suffix: .yen)
                    ).format(),
                    imageURL: $0.imageURL
                )
            },
            totalCount: model.totalCount,
            currentPage: model.currentPage,
            maxPage: model.maxPage
        )
    }
}
