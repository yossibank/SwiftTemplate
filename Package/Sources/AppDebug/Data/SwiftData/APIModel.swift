import SwiftData
import SwiftUI

@Model
public final class APIModel: @unchecked Sendable {
    @Attribute(.unique)
    public var id: String
    public var date: Date
    public var host: String?
    public var path: String?
    public var requestHeaders: [String: String?]?
    public var responseHeaders: [String: String?]?
    public var errorDescription: String?
    public var errorLocalizedDescription: String?
    public var httpMethod: String?
    public var httpBody: String?
    public var responseBody: String?
    public var responseSize: String?
    public var queryItems: [String: String?]
    public var statusCode: Int

    public init(
        id: String = UUID().uuidString,
        date: Date = .now,
        host: String?,
        path: String?,
        requestHeaders: [String: String?]?,
        responseHeaders: [String: String?],
        errorDescription: String?,
        errorLocalizedDescription: String?,
        httpMethod: String?,
        httpBody: String?,
        responseBody: String?,
        responseSize: String?,
        queryItems: [String: String?],
        statusCode: Int
    ) {
        self.id = id
        self.date = date
        self.host = host
        self.path = path
        self.requestHeaders = requestHeaders
        self.responseHeaders = responseHeaders
        self.errorDescription = errorDescription
        self.errorLocalizedDescription = errorLocalizedDescription
        self.httpMethod = httpMethod
        self.httpBody = httpBody
        self.responseBody = responseBody
        self.responseSize = responseSize
        self.queryItems = queryItems
        self.statusCode = statusCode
    }

    public init(item: APIModelItem) {
        self.id = UUID().uuidString
        self.date = .now
        self.host = item.urlRequest.url?.host(percentEncoded: false)
        self.path = item.urlRequest.url?.path(percentEncoded: false)
        self.requestHeaders = item.urlRequest.allHTTPHeaderFields
        self.responseHeaders = item.urlResponse?.allHeaderFields as? [String: String?]
        self.errorDescription = item.errorDescription
        self.errorLocalizedDescription = item.errorLocalizedDescription
        self.httpMethod = item.urlRequest.httpMethod

        self.httpBody = {
            guard let data = item.urlRequest.httpBody else {
                return nil
            }

            return String(data: data, encoding: .utf8)
        }()

        self.responseBody = {
            guard
                let data = item.data,
                let responseBody = String(data: data, encoding: .utf8)
            else {
                return nil
            }

            return responseBody
        }()

        self.responseSize = {
            guard let data = item.data else {
                return nil
            }

            let formatter = ByteCountFormatter()
            formatter.allowedUnits = [.useKB]
            formatter.isAdaptive = true
            formatter.zeroPadsFractionDigits = true
            formatter.countStyle = .binary
            return formatter.string(fromByteCount: Int64(data.count))
        }()

        self.queryItems = {
            guard let queryItems = item.queryItems else {
                return [:]
            }

            return queryItems.reduce(into: [String: String?]()) {
                $0[$1.name] = $1.value
            }
        }()

        self.statusCode = {
            guard let response = item.urlResponse else {
                return 0
            }

            return response.statusCode
        }()
    }
}

public extension APIModel {
    static let mock = APIModel(
        date: Date().addingTimeInterval(-20),
        host: "app.rakuten.co.jp",
        path: "/services/api/IchibaItem/Search/20220601/",
        requestHeaders: ["Content-Type": "application/json"],
        responseHeaders: ["Content-Type": "application/json"],
        errorDescription: "エラーのタイトル",
        errorLocalizedDescription: "エラーの詳細",
        httpMethod: "GET",
        httpBody: """
        {"userId":1,"id":1,"title":"sunt aut facere repellat provident occaecati excepturi optio reprehenderit"}
        """,
        responseBody: """
        {"userId":2,"id":2,"title":"sunt aut facere repellat provident occaecati excepturi optio reprehenderit"}
        """,
        responseSize: "100KB",
        queryItems: [
            "applicationId": "1032211485929725116",
            "formatVersion": "2",
            "hits": "30",
            "keyword": "からあげ",
            "page": "1"
        ],
        statusCode: 200
    )
}
