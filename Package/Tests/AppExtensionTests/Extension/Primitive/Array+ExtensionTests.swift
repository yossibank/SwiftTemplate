@testable import AppExtension
import Testing

actor ArrayExtensionTests {
    @Test("配列内の要素を指定indexから取得できること")
    func subscriptSafe() {
        // arrange
        let values = ["a", "b", "c"]

        // act
        let actual = values[safe: 2]

        // assert
        #expect(actual == "c")
    }

    @Test("配列内の要素が指定indexにない場合にnilを返すこと")
    func subscriptNil() {
        // arrange
        let values = ["a", "b", "c"]

        // act
        let actual = values[safe: 10]

        // assert
        #expect(actual == nil)
    }

    @Test("配列内の要素が空でないことを確認できること(true)")
    func isNotEmptyTrue() {
        // arrange
        let values = ["isNotEmpty"]

        // act
        let actual = values.isNotEmpty

        // assert
        #expect(actual)
    }

    @Test("配列内の要素が空でないことを確認できること(false)")
    func isNotEmptyFalse() {
        // arrange
        let values = [String]()

        // act
        let actual = values.isNotEmpty

        // assert
        #expect(!actual)
    }
}
