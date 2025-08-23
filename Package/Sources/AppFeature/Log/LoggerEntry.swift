import Foundation

public struct LoggerEntry {
    public let date: Date
    public let category: Logger.Category
    public let message: String

    public init(
        date: Date,
        category: Logger.Category,
        message: String
    ) {
        self.date = date
        self.category = category
        self.message = message
    }
}
