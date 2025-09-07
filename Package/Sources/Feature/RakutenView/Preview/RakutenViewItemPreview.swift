import Foundation

extension RakutenViewItem {
    static let preview: [RakutenViewItem.Item] = [
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
}
