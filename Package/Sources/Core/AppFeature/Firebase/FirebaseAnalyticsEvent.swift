import Foundation

public enum FirebaseAnalyticsEvent: Hashable, Codable, Sendable {
    case boot(date: String)

    public var name: String {
        switch self {
        case .boot: "boot"
        }
    }

    public var parameters: [String: Any] {
        var parameters = [FirebaseAnalyticsParameter: Any]()

        switch self {
        case let .boot(value):
            parameters[.bootDate] = value
        }

        return parameters.reduce(into: [String: Any]()) {
            $0[$1.key.value] = $1.value
        }
    }

    public var logMessage: String? {
        guard
            let data = try? JSONEncoder().encode(self),
            let jsonMessage = String(data: data, encoding: .utf8)
        else {
            return nil
        }

        return jsonMessage
    }
}

public extension FirebaseAnalyticsEvent {
    static func == (
        lhs: FirebaseAnalyticsEvent,
        rhs: FirebaseAnalyticsEvent
    ) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

public extension String.SubSequence {
    var analyticsEvent: FirebaseAnalyticsEvent? {
        let json = trimmingCharacters(in: .whitespaces)

        guard
            let data = json.data(using: .utf8),
            let event = try? JSONDecoder().decode(
                FirebaseAnalyticsEvent.self,
                from: data
            )
        else {
            return nil
        }

        return event
    }
}
