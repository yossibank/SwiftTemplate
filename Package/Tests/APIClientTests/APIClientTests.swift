@testable import APIClient
import OHHTTPStubs
import OHHTTPStubsSwift
import Testing

@Suite(.serialized)
actor APIClientTests {
    deinit {
        HTTPStubs.removeAllStubs()
    }

    @Test("正しくレスポンスが取得できること")
    func responseSuccess() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            fixture(
                filePath: OHPathForFileInBundle(
                    "success.json",
                    .module
                )!,
                headers: [
                    "Content-Type": "application/json"
                ]
            )
        }

        // act
        let response = try await APIClient().request(
            item: MockRequest(parameters: .init(userId: 1))
        )

        // assert
        #expect(response.count == 10)
        #expect(response.first?.userId == 1)
    }

    @Test("デコードエラーをキャッチできること")
    func responseDecodeError() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            fixture(
                filePath: OHPathForFileInBundle(
                    "failure.json",
                    .module
                )!,
                headers: [
                    "Content-Type": "application/json"
                ]
            )
        }

        do {
            // act
            _ = try await APIClient().request(
                item: MockRequest(parameters: .init(userId: 1))
            )
        } catch {
            // assert
            #expect(error as! APIError == .decode("データのフォーマットが正しくないため、読み込めませんでした。"))
        }
    }

    @Test("タイムアウトエラーをキャッチできること")
    func responseTimeoutError() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            let error = NSError(
                domain: NSURLErrorDomain,
                code: URLError.timedOut.rawValue
            )
            return HTTPStubsResponse(error: error)
        }

        do {
            // act
            _ = try await APIClient().request(
                item: MockRequest(parameters: .init(userId: 1))
            )
        } catch {
            // assert
            #expect(error as! APIError == .timeout)
        }
    }

    @Test("インターネット接続エラーをキャッチできること")
    func responseNotConnectedToInternetError() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            let error = NSError(
                domain: NSURLErrorDomain,
                code: URLError.notConnectedToInternet.rawValue
            )
            return HTTPStubsResponse(error: error)
        }

        do {
            // act
            _ = try await APIClient().request(
                item: MockRequest(parameters: .init(userId: 1))
            )
        } catch {
            // assert
            #expect(error as! APIError == .notConnectedToInternet)
        }
    }

    @Test("ステータスコードエラーをキャッチできること")
    func responseInvalidStatusCodeError() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            fixture(
                filePath: OHPathForFileInBundle(
                    "success.json",
                    .module
                )!,
                status: 500,
                headers: [
                    "Content-Type": "application/json"
                ]
            )
        }

        do {
            // act
            _ = try await APIClient().request(
                item: MockRequest(parameters: .init(userId: 1))
            )
        } catch {
            // assert
            #expect(error as! APIError == .invalidStatusCode(500))
        }
    }

    @Test("不明なエラーをキャッチできること")
    func responseUnknownError() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            let error = NSError(
                domain: NSURLErrorDomain,
                code: URLError.unknown.rawValue
            )
            return HTTPStubsResponse(error: error)
        }

        do {
            // act
            _ = try await APIClient().request(
                item: MockRequest(parameters: .init(userId: 1))
            )
        } catch {
            // assert
            #expect(error as! APIError == .unknown)
        }
    }
}

private extension APIClientTests {
    struct MockResponse: DataStructure {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }

    struct MockRequest: APIRequest {
        typealias APIResponse = [MockResponse]
        typealias PathComponent = EmptyPathComponent

        struct Parameters: Encodable {
            let userId: Int?
        }

        let baseURL = "http://mock.com"
        let path = "/user/list"
        let method = HTTPMethod.get
        let parameters: Parameters

        init(
            parameters: Parameters,
            pathComponent: PathComponent = .init()
        ) {
            self.parameters = parameters
        }
    }
}
