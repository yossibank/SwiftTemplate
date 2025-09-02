import Foundation

public struct APIModelItem: Sendable {
    public let data: Data?
    public let errorDescription: String?
    public let errorLocalizedDescription: String?
    public let urlRequest: URLRequest
    public let urlResponse: HTTPURLResponse?
    public let queryItems: [URLQueryItem]?

    public init(
        data: Data?,
        errorDescription: String?,
        errorLocalizedDescription: String?,
        urlRequest: URLRequest,
        urlResponse: HTTPURLResponse?,
        queryItems: [URLQueryItem]?
    ) {
        self.data = data
        self.errorDescription = errorDescription
        self.errorLocalizedDescription = errorLocalizedDescription
        self.urlRequest = urlRequest
        self.urlResponse = urlResponse
        self.queryItems = queryItems
    }
}
