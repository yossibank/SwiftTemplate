enum Route: Hashable {
    case log(Log)

    var title: String {
        switch self {
        case let .log(log): log.title
        }
    }

    enum Log: Hashable {
        case app
        case api(API)

        enum API: Hashable {
            case list
            case detail(APIModel)
            case body(APIModel, APIResponseBodyMode)

            var title: String {
                switch self {
                case .list: "APIログ"
                case .detail: "レスポンス詳細"
                case .body: "レスポンス中身"
                }
            }
        }

        var title: String {
            switch self {
            case .app: "アプリログ"
            case let .api(api): api.title
            }
        }
    }
}
