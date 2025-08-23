@testable import AppExtension
import Foundation
import Testing

actor ObjectAppliableTests {
    private class Object: ObjectAppliable {
        var text1 = ""
        var text2 = ""
        var text3 = ""
    }

    @Test("クロージャ内で自身プロパティにアクセスできること")
    func apply() {
        // arrange
        let object1 = Object()

        let expected = Object()
        expected.text1 = "text1"
        expected.text2 = "text2"
        expected.text3 = "text3"

        // act
        let actual = Object().apply {
            $0.text1 = "text1"
            $0.text2 = "text2"
            $0.text3 = "text3"
        }

        // assert
        #expect(actual.text1 == expected.text1)
        #expect(actual.text2 == expected.text2)
        #expect(actual.text3 == expected.text3)
    }
}
