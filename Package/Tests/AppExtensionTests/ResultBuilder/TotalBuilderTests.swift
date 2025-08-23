@testable import AppExtension
import Foundation
import Testing

actor TotalBuilderTests {
    @Test("要素に対応")
    func buildBlock() {
        // arrange
        let expected: CGFloat = 10

        // act
        @TotalAmountBuilder
        var actual: CGFloat {
            1.0
            2.0
            3.0
            4.0
        }

        // assert
        #expect(actual == expected)
    }

    @Test("要素変換(Int型)")
    func buildExpressionInt() {
        // arrange
        let int1 = 1
        let int2 = 2
        let int3 = 3
        let int4 = 4

        let expected: CGFloat = 10

        // act
        @TotalAmountBuilder
        var actual: CGFloat {
            int1
            int2
            int3
            int4
        }

        // assert
        #expect(actual == expected)
    }

    @Test("要素変換(Double型)")
    func buildExpressionDouble() {
        // arrange
        let double1: Double = 1
        let double2: Double = 2
        let double3: Double = 3
        let double4: Double = 4

        let expected: CGFloat = 10

        // act
        @TotalAmountBuilder
        var actual: CGFloat {
            double1
            double2
            double3
            double4
        }

        // assert
        #expect(actual == expected)
    }

    @Test("Optional型に対応")
    func buildOptional() {
        // arrange
        let value1: CGFloat = 1
        let value2: CGFloat = 2
        let value3: CGFloat = 3
        let value4: CGFloat = 4
        let value5: CGFloat? = 5
        let value6: CGFloat? = 6

        let expected: CGFloat = 21

        // act
        @TotalAmountBuilder
        var actual: CGFloat {
            value1
            value2
            value3
            value4

            if let value5 {
                value5
            }

            if let value6 {
                value6
            }
        }

        // assert
        #expect(actual == expected)
    }

    @Test("if文 true条件に対応")
    func buildEitherTrue() {
        // arrange
        let bool = 0 == 0
        let expected: CGFloat = 15

        // act
        @TotalAmountBuilder
        var actual: CGFloat {
            1
            2
            3
            4

            if bool {
                5
            } else {
                6
            }
        }

        // assert
        #expect(actual == expected)
    }

    @Test("if文 false条件に対応")
    func buildEitherFalse() {
        // arrange
        let bool = 0 == 1
        let expected: CGFloat = 16

        // act
        @TotalAmountBuilder
        var actual: CGFloat {
            1
            2
            3
            4

            if bool {
                5
            } else {
                6
            }
        }

        // assert
        #expect(actual == expected)
    }
}
