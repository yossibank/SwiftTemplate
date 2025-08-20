import Foundation

/// @mockable
public protocol APIClientProtocol {
    func request<T>(item: some APIRequest<T>) async throws -> T
}

public struct APIClient: APIClientProtocol {
    public init() {}

    public func request<T>(item: some APIRequest<T>) async throws -> T {
        guard let urlRequest = createURLRequest(item) else {
            throw APIError.invalidRequest
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let urlResponse = response as? HTTPURLResponse else {
                throw APIError.emptyResponse
            }

            guard (200...299).contains(urlResponse.statusCode) else {
                throw APIError.invalidStatusCode(urlResponse.statusCode)
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try JSONDecoder().decode(
                T.self,
                from: data
            )
        } catch {
            throw APIError.parse(error)
        }
    }
}

private extension APIClient {
    func createURLRequest(_ request: some APIRequest) -> URLRequest? {
        guard let fullPath = URL(string: request.baseURL + request.path) else {
            return nil
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = fullPath.scheme
        urlComponents.port = fullPath.port
        urlComponents.queryItems = request.queryItems
        urlComponents.host = fullPath.host()
        urlComponents.path = fullPath.path()

        guard let url = urlComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = request.timeoutInterval
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        request.headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }

        return urlRequest
    }
}
