enum Route: Hashable {
    case log(Log)

    var title: String {
        switch self {
        case let .log(log): log.title
        }
    }

    enum Log {
        case app

        var title: String {
            switch self {
            case .app: "アプリログ"
            }
        }
    }
}
