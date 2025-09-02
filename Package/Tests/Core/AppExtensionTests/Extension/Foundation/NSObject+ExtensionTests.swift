@testable import AppExtension
import Foundation
import Testing

actor NSObjectExtensionTests {
    private final class SampleClass: NSObject {}

    @Test("クラス名が正しく取得できること(Static)")
    func classNameStatic() {
        // arrange
        let expected = "SampleClass"

        // act
        let actual = SampleClass.className

        // assert
        #expect(actual == expected)
    }

    @Test("クラス名が正しく取得できること")
    func className() {
        // arrange
        let expected = "SampleClass"

        // act
        let actual = SampleClass().className

        // assert
        #expect(actual == expected)
    }
}
