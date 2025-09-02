import Foundation
import OSLog

public actor LoggerStore {
    public init() {}

    public func allEntries() throws -> [LoggerEntry] {
        let store = try OSLogStore(scope: .currentProcessIdentifier)
        let posision = store.position(timeIntervalSinceLatestBoot: 1)

        let entries: [LoggerEntry] = try store
            .getEntries(at: posision)
            .compactMap { $0 as? OSLogEntryLog }
            .compactMap {
                guard let category = Logger.Category(rawValue: $0.category) else {
                    return nil
                }

                switch category {
                case .firebase:
                    guard
                        let message = $0.composedMessage.split(
                            separator: "jsonMessage:",
                            maxSplits: 1,
                            omittingEmptySubsequences: false
                        ).last,
                        let event = message.analyticsEvent
                    else {
                        return nil
                    }

                    return .init(
                        date: $0.date,
                        category: category,
                        message: .event(event),
                        eventCount: 0
                    )

                default:
                    return .init(
                        date: $0.date,
                        category: category,
                        message: .text($0.composedMessage),
                        eventCount: 0
                    )
                }
            }
            .sorted(
                by: {
                    $0.date > $1.date
                }
            )

        let eventCounts = Dictionary(
            grouping: entries,
            by: {
                switch $0.message {
                case let .text(message): message
                case let .event(event): event.name
                }
            }
        ).mapValues { $0.count }

        let newEntries = entries.map { entry in
            LoggerEntry(
                date: entry.date,
                category: entry.category,
                message: entry.message,
                eventCount: {
                    switch entry.message {
                    case let .text(text): eventCounts[text] ?? 0
                    case let .event(event): eventCounts[event.name] ?? 0
                    }
                }()
            )
        }

        return newEntries
    }
}
