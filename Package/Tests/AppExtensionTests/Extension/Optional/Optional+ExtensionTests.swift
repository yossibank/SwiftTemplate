@testable import AppExtension
import Foundation
import Testing

actor OptionalExtensionTests {
    @Test("Bool?型(Bool) → Bool型に変換できること")
    func unwrappedBool() {
        // arrange
        let value: Bool? = true
        let expected = true

        // act
        let actual = value.unwraped

        // assert
        #expect(actual == expected)
    }

    @Test("Bool?型(nil) → Bool型「false」に変換できること")
    func unwrappedBoolNil() {
        // arrange
        let value: Bool? = nil
        let expected = false

        // act
        let actual = value.unwraped

        // assert
        #expect(actual == expected)
    }

    @Test("CGFloat?型(CGFloat) → CGFloat型に変換できること")
    func unwrappedCGFloat() {
        // arrange
        let value: CGFloat? = 1.5
        let expected: CGFloat = 1.5

        // act
        let actual = value.unwrapped

        // assert
        #expect(actual == expected)
    }

    @Test("CGFloat?型(nil) → CGFloat型「0.0」に変換できること")
    func unwrappedCGFloatNil() {
        // arrange
        let value: CGFloat? = nil
        let expected: CGFloat = 0.0

        // act
        let actual = value.unwrapped

        // assert
        #expect(actual == expected)
    }

    @Test("Double?型(Double) → Double型に変換できること")
    func unwrappedDouble() {
        // arrange
        let value: Double? = 1.5
        let expected = 1.5

        // act
        let actual = value.unwrapped

        // assert
        #expect(actual == expected)
    }

    @Test("Double?型(nil) → 0.0に変換できること")
    func unwrappedDoubleNil() {
        // arrange
        let value: Double? = nil
        let expected = 0.0

        // act
        let actual = value.unwrapped

        // assert
        #expect(actual == expected)
    }

    @Test("Double?型(Double) → String型に変換できること")
    func toStringDouble() {
        // arrange
        let value: Double? = 1.5
        let expected = "1.5"

        // act
        let actual = value.toString

        // assert
        #expect(actual == expected)
    }

    @Test("Double?型(nil) → String型「0.0」に変換できること")
    func toStringDoubleNil() {
        // arrange
        let value: Double? = nil
        let expected = "0.0"

        // act
        let actual = value.toString

        // assert
        #expect(actual == expected)
    }

    @Test("Double?型(Double) → Int型に変換できること")
    func toIntDouble() {
        // arrange
        let value: Double? = 1.5
        let expected = 1

        // act
        let actual = value.toInt

        // assert
        #expect(actual == expected)
    }

    @Test("Double?型(nil) → Int型「0」に変換できること")
    func toIntDoubleNil() {
        // arrange
        let value: Double? = nil
        let expected = 0

        // act
        let actual = value.toInt

        // assert
        #expect(actual == expected)
    }

    @Test("Int?型(Int) → Int型に変換できること")
    func unwrappedInt() {
        // arrange
        let value: Int? = 10
        let expected = 10

        // act
        let actual = value.unwrapped

        // assert
        #expect(actual == expected)
    }

    @Test("Int?型(nil) → Int型「0」に変換できること")
    func unwrappedIntNil() {
        // arrange
        let value: Int? = nil
        let expected = 0

        // act
        let actual = value.unwrapped

        // assert
        #expect(actual == expected)
    }

    @Test("Int?型(Int) → String型に変換できること")
    func toStringInt() {
        // arrange
        let value: Int? = 10
        let expected = "10"

        // act
        let actual = value.toString

        // assert
        #expect(actual == expected)
    }

    @Test("Int?型(nil) → String型「0」に変換できること")
    func toStringIntNil() {
        // arrange
        let value: Int? = nil
        let expected = "0"

        // act
        let actual = value.toString

        // assert
        #expect(actual == expected)
    }

    @Test("Int?型(Int) → Double型に変換できること")
    func toDoubleInt() {
        // arrange
        let value: Int? = 10
        let expected: Double = 10

        // act
        let actual = value.toDouble

        // assert
        #expect(actual == expected)
    }

    @Test("Int?型(nil) → Double型「0.0」に変換できること")
    func toDoubleIntNil() {
        // arrange
        let value: Int? = nil
        let expected = 0.0

        // act
        let actual = value.toDouble

        // assert
        #expect(actual == expected)
    }

    @Test("Int?型「1」 → Bool型に変換できること")
    func toBoolInt() {
        // arrange
        let value: Int? = 1
        let expected = true

        // act
        let actual = value.toBool

        // assert
        #expect(actual == expected)
    }

    @Test("Int?型(nil) → Bool型「false」に変換できること")
    func toBoolIntNil() {
        // arrange
        let value: Int? = nil
        let expected = false

        // act
        let actual = value.toBool

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(String) → String型に変換できること")
    func unwrappedString() {
        // arrange
        let value: String? = "Hello"
        let expected = "Hello"

        // act
        let actual = value.unwrapped

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(nil) → String型「空文字」に変換できること")
    func unwrappedStringNil() {
        // arrange
        let value: String? = nil
        let expected = ""

        // act
        let actual = value.unwrapped

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(String) → Int型に変換できること")
    func toIntString() {
        // arrange
        let value: String? = "10"
        let expected = 10

        // act
        let actual = value.toInt

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(nil) → Int型「nil」に変換できること")
    func toIntStringNil() {
        // arrange
        let value: String? = nil
        let expected: Int? = nil

        // act
        let actual = value.toInt

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(String) → Double型に変換できること")
    func toDoubleString() {
        // arrange
        let value: String? = "10"
        let expected = 10.0

        // act
        let actual = value.toDouble

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(nil) → Double型「nil」に変換できること")
    func toDoubleStringNil() {
        // arrange
        let value: String? = nil
        let expected: Double? = nil

        // act
        let actual = value.toDouble

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(String) → 空文字でない判定ができること(true)")
    func isNotEmptyString() {
        // arrange
        let value: String? = "Hello"
        let expected = true

        // act
        let actual = value.isNotEmpty

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(nil) → 空文字でない判定ができること(false)")
    func isNotEmptyStringNil() {
        // arrange
        let value: String? = nil
        let expected = false

        // act
        let actual = value.isNotEmpty

        // assert
        #expect(actual == expected)
    }
}
