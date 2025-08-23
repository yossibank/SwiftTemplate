@testable import AppExtension
import Testing

actor DoubleExtensionTests {
    @Test("Double型 → String型に変換できること")
    func toString() {
        // arrange
        let value = 123.456
        let expected = "123.456"

        // act
        let actual = value.toString

        // assert
        #expect(actual == expected)
    }

    @Test("Double型 → Int型に変換できること")
    func toInt() {
        // arrange
        let value = 123.456
        let expected = 123

        // act
        let actual = value.toInt

        // assert
        #expect(actual == expected)
    }
}
