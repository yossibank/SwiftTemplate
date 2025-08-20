import Foundation

public enum APIError: Error, Equatable {
    case decode(String)
    case timeout
    case notConnectedToInternet
    case emptyResponse
    case invalidRequest
    case invalidStatusCode(Int)
    case unknown
}

public extension APIError {
    static func parse(_ error: any Error) -> APIError {
        if error is DecodingError {
            return .decode(error.localizedDescription)
        }

        // -1001エラー
        // https://developer.apple.com/documentation/foundation/1508628-url_loading_system_error_codes/nsurlerrortimedout
        if error._code == NSURLErrorTimedOut {
            return .timeout
        }

        // -1009エラー
        // https://developer.apple.com/documentation/foundation/1508628-url_loading_system_error_codes/nsurlerrornotconnectedtointernet
        if error._code == NSURLErrorNotConnectedToInternet {
            return .notConnectedToInternet
        }

        guard let apiError = error as? APIError else {
            return .unknown
        }

        return apiError
    }
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .decode(description):
            "Decode error: \(description)"

        case .timeout:
            "Timeout error"

        case .notConnectedToInternet:
            "Not　Connected　To　Internet error"

        case .emptyResponse:
            "Empty Response error"

        case .invalidRequest:
            "Invalid Request error"

        case let .invalidStatusCode(code):
            "Invalid Status Code error: 【\(code)】"

        case .unknown:
            "Unknown error"
        }
    }
}
