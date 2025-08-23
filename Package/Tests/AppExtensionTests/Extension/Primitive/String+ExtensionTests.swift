@testable import AppExtension
import Testing

actor StringExtensionTests {
    @Test("String型 → Int?型に変換できること")
    func toInt() {
        // arrange
        let value = "123"
        let expected: Int? = 123

        // act
        let actual = value.toInt

        // assert
        #expect(actual == expected)
    }

    @Test("String型 → Double?型に変換できること")
    func toDouble() {
        // arrange
        let value = "123"
        let expected: Double? = 123.0

        // act
        let actual = value.toDouble

        // assert
        #expect(actual == expected)
    }

    @Test("String型(String) → 空文字でない判定ができること(true)")
    func isNotEmpty() {
        // arrange
        let value: String? = "Hello"
        let expected = true

        // act
        let actual = value.isNotEmpty

        // assert
        #expect(actual == expected)
    }

    @Test("String?型(nil) → 空文字でない判定ができること(false)")
    func isNotEmptyNil() {
        // arrange
        let value: String? = nil
        let expected = false

        // act
        let actual = value.isNotEmpty

        // assert
        #expect(actual == expected)
    }
}
