@testable import Rakuten
@testable import RakutenView
import Testing

actor RakutenConverterTests {
    private let converter = RakutenConverter()

    @Test("RakutenModel → RakutenViewItemに変換できること")
    func convert() {
        // arrange
        let model = RakutenModel.testData
        let expected = RakutenViewItem.testData

        // act
        let actaul = converter.convert(model)

        // assert
        #expect(actaul == expected)
    }
}
