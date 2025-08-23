public struct ValueFormat {
    public let prefix: Prefix
    public let suffix: Suffix
    public let scale: Int

    public enum Prefix {
        case plus
        case none

        public var value: String {
            switch self {
            case .plus: "+"
            case .none: ""
            }
        }
    }

    public enum Suffix {
        case yen
        case dollar
        case date
        case percent
        case none

        public var value: String {
            switch self {
            case .yen: "円"
            case .dollar: "ドル"
            case .date: "日"
            case .percent: "%"
            case .none: ""
            }
        }
    }

    public init(
        prefix: Prefix = .none,
        suffix: Suffix = .none,
        scale: Int = 0
    ) {
        self.prefix = prefix
        self.suffix = suffix
        self.scale = scale
    }
}
