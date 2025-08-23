import Foundation
import OSLog

public actor LoggerStore {
    public init() {}

    public func allEntries() throws -> [LoggerEntry] {
        let store = try OSLogStore(scope: .currentProcessIdentifier)
        let posision = store.position(timeIntervalSinceLatestBoot: 1)

        return try store
            .getEntries(at: posision)
            .compactMap { $0 as? OSLogEntryLog }
            .compactMap {
                guard let category = Logger.Category(rawValue: $0.category) else {
                    return nil
                }

                return .init(
                    date: $0.date,
                    category: category,
                    message: $0.composedMessage
                )
            }
            .sorted(
                by: {
                    $0.date > $1.date
                }
            )
    }
}
