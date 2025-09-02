import Foundation

public struct EmptyParameters: Encodable, Equatable {
    public init() {}
}

public struct EmptyAPIResponse: Codable, Equatable {
    public init() {}
}

public struct EmptyPathComponent {
    public init() {}
}
