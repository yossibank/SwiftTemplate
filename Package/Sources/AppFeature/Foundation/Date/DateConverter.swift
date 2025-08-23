import Foundation

public struct DateConverter {
    public var calendar: Calendar {
        dateFormatter.calendar
    }

    private let dateFormatter: DateFormatter

    public init(_ locale: AppDateLocale = .us) {
        self.dateFormatter = AppDate.dateFormatter(locale)
    }
}

public extension DateConverter {
    func formatToString(
        _ dateString: String?,
        format: DateFormat
    ) -> String {
        guard
            let dateString,
            dateString.isNotEmpty
        else {
            return ""
        }

        dateFormatter.dateFormat = format.value

        for dateFormat in DateFormat.all {
            dateFormatter.dateFormat = dateFormat

            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = format.value
                return dateFormatter.string(from: date)
            }
        }

        return dateString
    }

    func dateToString(
        _ date: Date,
        format: DateFormat
    ) -> String {
        dateFormatter.dateFormat = format.value
        return dateFormatter.string(from: date)
    }

    func stringToDate(
        _ dateString: String,
        format: DateFormat
    ) -> Date? {
        dateFormatter.dateFormat = format.value
        return dateFormatter.date(from: dateString)
    }

    func timeDifference(
        _ nowDate: Date = .now,
        targetDate: Date
    ) -> String {
        let difference = Int(nowDate.timeIntervalSince(targetDate))
        let hours = difference / 3600
        let minutes = (difference % 3600) / 60
        let seconds = difference % 60

        if hours > 0 {
            return "\(hours)時間\(minutes)分\(seconds)秒前"
        }

        if minutes > 0 {
            return "\(minutes)分\(seconds)秒前"
        }

        return "\(seconds)秒前"
    }
}
