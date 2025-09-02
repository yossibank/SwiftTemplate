@testable import AppExtension
import Testing

actor IntExtensionTests {
    @Test("Int型 → String型に変換できること")
    func toString() {
        // arrange
        let value = 123
        let expected = "123"

        // act
        let actual = value.toString

        // assert
        #expect(actual == expected)
    }

    @Test("Int型 → Double型に変換できること")
    func toInt() {
        // arrange
        let value = 123
        let expected = 123.0

        // act
        let actual = value.toDouble

        // assert
        #expect(actual == expected)
    }

    @Test("Int型 → Bool型に変換できること(true)")
    func toBoolTrue() {
        // arrange
        let value = 1
        let expected = true

        // act
        let actual = value.toBool

        // assert
        #expect(actual == expected)
    }

    @Test("Int型 → Bool型に変換できること(false)")
    func toBoolFalse() {
        // arrange
        let value = 0
        let expected = false

        // act
        let actual = value.toBool

        // assert
        #expect(actual == expected)
    }
}
