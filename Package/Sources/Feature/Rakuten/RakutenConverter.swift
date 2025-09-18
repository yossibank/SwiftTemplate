import AppFoundation
import AutoInitMacro
import RakutenView

/// @mockable
public protocol RakutenConverterProtocol: Sendable {
    func convert(_ model: RakutenModel) -> RakutenViewItem
}

@AutoInit
public struct RakutenConverter: RakutenConverterProtocol {
    private let valueConverter = ValueConverter()

    public func convert(_ model: RakutenModel) -> RakutenViewItem {
        RakutenViewItem(
            items: model.items.map {
                RakutenViewItem.Item(
                    id: $0.id,
                    name: $0.name,
                    price: valueConverter.format(
                        ValueConverter.Formatter(
                            value: $0.price,
                            valueFormat: ValueFormat(suffix: .yen)
                        )
                    ),
                    imageURL: $0.imageURL
                )
            },
            totalCount: model.totalCount,
            currentPage: model.currentPage,
            maxPage: model.maxPage
        )
    }
}
