import APIClient
import AppExtension
import Foundation

/// @mockable
public protocol RakutenTranslatorProtocol: Sendable {
    func translate(_ entity: RakutenEntity) -> RakutenModel
}

public struct RakutenTranslator: RakutenTranslatorProtocol {
    public init() {}

    public func translate(_ entity: RakutenEntity) -> RakutenModel {
        .init(
            items: entity.items.map {
                RakutenModel.RakutenItem(
                    id: $0.itemCode,
                    name: $0.itemName,
                    description: $0.itemCaption,
                    price: $0.itemPrice.toDouble,
                    imageURL: $0.mediumImageUrls.compactMap {
                        URL(string: $0)
                    }.first,
                    imageURLs: $0.mediumImageUrls.compactMap {
                        URL(string: $0)
                    },
                    itemURL: .init(string: $0.itemUrl)
                )
            },
            totalCount: entity.count,
            currentPage: entity.page,
            maxPage: entity.pageCount
        )
    }
}
