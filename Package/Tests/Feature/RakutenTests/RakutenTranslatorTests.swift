@testable import Rakuten
import Testing

actor RakutenTranslatorTests {
    private let translator = RakutenTranslator()

    @Test("RakutenEntity → RakutenModelに変換できること")
    func translate() {
        // arrange
        let entity = RakutenEntityMock.testData
        let expected = RakutenModelMock.testData

        // act
        let actual = translator.translate(entity)

        // assert
        #expect(actual == expected)
    }
}
