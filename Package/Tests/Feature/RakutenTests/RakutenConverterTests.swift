@testable import Rakuten
@testable import RakutenView
import Testing

actor RakutenConverterTests {
    private let converter = RakutenConverter()

    @Test("RakutenModel → RakutenViewItemに変換できること")
    func convert() {
        // arrange
        let model = RakutenModelMock.testData
        let expected = RakutenViewItemMock.testData

        // act
        let actaul = converter.convert(model)

        // assert
        #expect(actaul == expected)
    }
}
