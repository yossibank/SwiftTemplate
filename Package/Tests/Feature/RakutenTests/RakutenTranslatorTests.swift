@testable import Rakuten
import Testing

actor RakutenTranslatorTests {
    private let translator = RakutenTranslator()

    @Test("RakutenEntity → RakutenModelに変換できること")
    func translate() {
        // arrange
        let entity = RakutenEntity.testData
        let expected = RakutenModel.testData

        // act
        let actual = translator.translate(entity)

        // assert
        #expect(actual == expected)
    }
}
