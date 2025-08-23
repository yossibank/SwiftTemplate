@testable import AppExtension
import Testing

actor ArrayBuilderTests {
    @Test("要素に対応")
    func buildBlock() {
        let exepcted = ["a", "b", "c"]

        // act
        @ArrayBuilder
        var actual: [String] {
            "a"
            "b"
            "c"
        }

        // assert
        #expect(actual == exepcted)
    }

    @Test("for-in文に対応")
    func buildArray() {
        // arrange
        let exepcted = ["a", "b", "c", "d"]

        // act
        @ArrayBuilder
        var actual: [String] {
            "a"

            for value in ["b", "c", "d"] {
                value
            }
        }

        // assert
        #expect(actual == exepcted)
    }

    @Test("Optional型に対応")
    func buildOptional() {
        // arrange
        let value: String? = "d"
        let expected = ["a", "b", "c", "d"]

        // act
        @ArrayBuilder
        var actual: [String] {
            for value in ["a", "b", "c"] {
                value
            }

            if let value {
                value
            }
        }

        // assert
        #expect(actual == expected)
    }

    @Test("if文 trueに対応")
    func buildEitherTrue() {
        // arrange
        let bool = 0 == 0
        let expected = [1, 2, 4, 5]

        // act
        @ArrayBuilder
        var actual: [Int] {
            1

            if bool {
                2
            } else {
                3
            }

            4
            5
        }

        // assert
        #expect(actual == expected)
    }

    @Test("if文 falseに対応")
    func buildEitherFalse() {
        // arrange
        let bool = 0 == 1
        let expected = [1, 3, 4, 5]

        // act
        @ArrayBuilder
        var actual: [Int] {
            1

            if bool {
                2
            } else {
                3
            }

            4
            5
        }

        // assert
        #expect(actual == expected)
    }
}
