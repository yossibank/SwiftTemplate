@testable import AppFeature
import Foundation
import Testing

@Suite(.serialized)
actor DateConverterTests {
    private let dateConverter = DateConverter()

    @Test("2024-08-27 12:30:00 → 2024年8月27日に変換できること")
    func formatToString() {
        // arrange
        let value = "2024-08-27 12:30:00"

        // act
        let actual = dateConverter.formatToString(
            value,
            format: .yyyyMdJp
        )

        // assert
        #expect(actual == "2024年8月27日")
    }

    @Test("日付(2024年8月27日12時34分56秒) → 2024/08/27 12:34:56に変換できること")
    func dateToString() {
        // arrange
        let value = dateConverter.calendar.date(
            from: .init(
                year: 2024,
                month: 8,
                day: 27,
                hour: 12,
                minute: 34,
                second: 56
            )
        )

        // act
        let actual = dateConverter.dateToString(
            value!,
            format: .yyyyMMddHHmmss
        )

        // assert
        #expect(actual == "2024/08/27 12:34:56")
    }

    @Test("2024/12/27 12:34:56 → 日付(2024年12月27日12時34分56秒)に変換できること")
    func stringToDate() {
        // arrange
        let value = "2024/12/27 12:34:56"

        let expected = dateConverter.calendar.date(
            from: .init(
                year: 2024,
                month: 12,
                day: 27,
                hour: 12,
                minute: 34,
                second: 56
            )
        )

        // act
        let actual = dateConverter.stringToDate(
            value,
            format: .yyyyMMddHHmmss
        )

        // assert
        #expect(actual == expected)
    }

    @Test("日付同士を比較して差分を出力できること(秒)")
    func timeDifferenceSeconds() {
        // arrange
        let nowDate = dateConverter.calendar.date(
            from: .init(
                year: 2024,
                month: 8,
                day: 27,
                hour: 12,
                minute: 34,
                second: 56
            )
        )

        let targetDate = dateConverter.calendar.date(
            from: .init(
                year: 2024,
                month: 8,
                day: 27,
                hour: 12,
                minute: 34,
                second: 54
            )
        )

        // act
        let actual = dateConverter.timeDifference(
            nowDate!,
            targetDate: targetDate!
        )

        // assert
        #expect(actual == "2秒前")
    }

    @Test("日付同士を比較して差分を出力できること(分)")
    func timeDifferenceMinutes() {
        // arrange
        let nowDate = dateConverter.calendar.date(
            from: .init(
                year: 2024,
                month: 8,
                day: 27,
                hour: 12,
                minute: 34,
                second: 56
            )
        )

        let targetDate = dateConverter.calendar.date(
            from: .init(
                year: 2024,
                month: 8,
                day: 27,
                hour: 12,
                minute: 32,
                second: 54
            )
        )

        // act
        let actual = dateConverter.timeDifference(
            nowDate!,
            targetDate: targetDate!
        )

        // assert
        #expect(actual == "2分2秒前")
    }

    @Test("日付同士を比較して差分を出力できること(時)")
    func timeDifferenceHour() {
        // arrange
        let nowDate = dateConverter.calendar.date(
            from: .init(
                year: 2024,
                month: 8,
                day: 27,
                hour: 12,
                minute: 34,
                second: 56
            )
        )

        let targetDate = dateConverter.calendar.date(
            from: .init(
                year: 2024,
                month: 8,
                day: 27,
                hour: 8,
                minute: 32,
                second: 54
            )
        )

        // act
        let actual = dateConverter.timeDifference(
            nowDate!,
            targetDate: targetDate!
        )

        // assert
        #expect(actual == "4時間2分2秒前")
    }
}
