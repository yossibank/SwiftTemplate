@testable import AppFeature
import Testing

actor ValueConverterTests {
    private let converter = ValueConverter()

    @Test("1000000 → +1,000,000にフォーマットできること")
    func prefixPlus() {
        // arrange
        let value: Double? = 1_000_000
        let expected = "+1,000,000"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(prefix: .plus)
            )
        )

        #expect(actual == expected)
    }

    @Test("1000000 → 1,000,000にフォーマットできること")
    func prefixNone() {
        // arrange
        let value: Double? = 1_000_000
        let expected = "1,000,000"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(prefix: .none)
            )
        )

        // assert
        #expect(actual == expected)
    }

    @Test("1000000 → 1,000,000円にフォーマットできること")
    func suffixYen() {
        // arrange
        let value: Double? = 1_000_000
        let expected = "1,000,000円"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(suffix: .yen)
            )
        )

        #expect(actual == expected)
    }

    @Test("1000 → 1,000ドルにフォーマットできること")
    func suffixDollar() {
        // arrange
        let value: Double? = 1000
        let expected = "1,000ドル"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(suffix: .dollar)
            )
        )

        #expect(actual == expected)
    }

    @Test("10 → 10日にフォーマットできること")
    func suffixDate() {
        // arrange
        let value: Double? = 10
        let expected = "10日"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(suffix: .date)
            )
        )

        #expect(actual == expected)
    }

    @Test("54 → 54%にフォーマットできること")
    func suffixPercent() {
        // arrange
        let value: Double? = 54
        let expected = "54%"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(suffix: .percent)
            )
        )

        #expect(actual == expected)
    }

    @Test("12345 → 12,345にフォーマットできること")
    func suffixNone() {
        // arrange
        let value: Double? = 12345
        let expected = "12,345"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(suffix: .none)
            )
        )

        #expect(actual == expected)
    }

    @Test("50.25 → 50にフォーマットできること")
    func scaleZero() {
        // arrange
        let value: Double? = 50.25
        let expected = "50"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(scale: 0)
            )
        )

        // assert
        #expect(actual == expected)
    }

    @Test("50.25 → 50.3にフォーマットできること")
    func scaleOne() {
        // arrange
        let value: Double? = 50.25
        let expected = "50.3"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(scale: 1)
            )
        )

        // assert
        #expect(actual == expected)
    }

    @Test("50.25 → 50,25にフォーマットできること")
    func scaleTwo() {
        // arrange
        let value: Double? = 50.25
        let expected = "50.25"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(scale: 2)
            )
        )

        // assert
        #expect(actual == expected)
    }

    @Test("100000.0 → +100,000円にフォーマットできること")
    func multiple() {
        // arrange
        let value: Double? = 100_000
        let expected = "+100,000.0円"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(prefix: .plus, suffix: .yen, scale: 1)
            )
        )

        // assert
        #expect(actual == expected)
    }

    @Test("-50.10 → -50.10にフォーマットできること(小数点以下の0を省略しない)")
    func decimalZero() {
        // arrange
        let value: Double? = -50.10
        let expected = "-50.10"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(scale: 2)
            )
        )

        // assert
        #expect(actual == expected)
    }

    @Test("0.00 → 0にフォーマットできること(小数点以下の0を省略する")
    func valueZero() {
        // arrange
        let value: Double? = 0.00
        let expected = "0"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init(scale: 2)
            )
        )

        // assert
        #expect(actual == expected)
    }

    @Test("nil → ---にフォーマットできること")
    func valueNil() {
        // arrange
        let value: Double? = nil
        let expected = "---"

        // act
        let actual = converter.format(
            .init(
                value: value,
                valueFormat: .init()
            )
        )

        // assert
        #expect(actual == expected)
    }
}
