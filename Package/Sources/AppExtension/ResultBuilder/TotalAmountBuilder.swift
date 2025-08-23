import Foundation

@resultBuilder
public enum TotalAmountBuilder {
    // 要素に対応
    public static func buildBlock(_ components: CGFloat...) -> [CGFloat] {
        components
    }

    // for-in文に対応
    public static func buildArray(_ components: [[CGFloat]]) -> CGFloat {
        components.flatMap(\.self).reduce(0, +)
    }

    // optional型に対応
    public static func buildOptional(_ component: [CGFloat]?) -> CGFloat {
        component?.reduce(0, +) ?? 0
    }

    // if文(true)に対応
    public static func buildEither(first component: [CGFloat]) -> CGFloat {
        component.reduce(0, +)
    }

    // if文(false)に対応
    public static func buildEither(second component: [CGFloat]) -> CGFloat {
        component.reduce(0, +)
    }

    // if #availableに対応
    public static func buildLimitedAvailability(_ component: [CGFloat]) -> [CGFloat] {
        component
    }

    // 要素変換(Int)
    public static func buildExpression(_ expression: Int) -> CGFloat {
        CGFloat(expression)
    }

    // 要素変換(Double)
    public static func buildExpression(_ expression: Double) -> CGFloat {
        CGFloat(expression)
    }

    // 最終出力値返却
    public static func buildFinalResult(_ component: [CGFloat]) -> CGFloat {
        component.reduce(0, +)
    }
}
