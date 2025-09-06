import Foundation

public struct LoggerEntry: Sendable {
    public let date: Date
    public let category: Logger.Category
    public let message: Logger.Message
    public let eventCount: Int

    public init(
        date: Date,
        category: Logger.Category,
        message: Logger.Message,
        eventCount: Int
    ) {
        self.date = date
        self.category = category
        self.message = message
        self.eventCount = eventCount
    }
}
