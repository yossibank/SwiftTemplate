import Foundation

@resultBuilder
public enum ArrayBuilder {
    // 要素に対応
    public static func buildBlock<Element>(_ components: Element...) -> [Element] {
        components
    }

    // 要素に対応
    public static func buildBlock<Element>(_ components: [Element]...) -> [Element] {
        components.flatMap(\.self)
    }

    // for-in文に対応
    public static func buildArray<Element>(_ components: [[Element]]) -> [Element] {
        components.flatMap(\.self)
    }

    // optional型に対応
    public static func buildOptional<Element>(_ component: [Element]?) -> [Element] {
        component ?? []
    }

    // if文(true)に対応
    public static func buildEither<Element>(first component: [Element]) -> [Element] {
        component
    }

    // if文(false)に対応
    public static func buildEither<Element>(second component: [Element]) -> [Element] {
        component
    }

    // if #availableに対応
    public static func buildLimitedAvailability<Element>(_ component: [Element]) -> [Element] {
        component
    }

    // 要素の型を統一して対応
    public static func buildExpression<Element>(_ expression: Element) -> [Element] {
        [expression]
    }
}
