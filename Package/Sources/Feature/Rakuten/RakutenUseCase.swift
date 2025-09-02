import APIClient

/// @mockable
public protocol RakutenUseCaseProtocol: Sendable {
    func search(keyword: String, page: Int) async throws -> RakutenModel
}

public final class RakutenUseCase: RakutenUseCaseProtocol {
    private let apiClient: any APIClientProtocol
    private let translator: any RakutenTranslatorProtocol

    public static func make() -> RakutenUseCase {
        .init(
            apiClient: APIClient(),
            translator: RakutenTranslator()
        )
    }

    public init(
        apiClient: any APIClientProtocol,
        translator: any RakutenTranslatorProtocol
    ) {
        self.apiClient = apiClient
        self.translator = translator
    }
}

public extension RakutenUseCase {
    func search(
        keyword: String,
        page: Int
    ) async throws -> RakutenModel {
        do {
            let entity = try await apiClient.request(
                item: RakutenRequest(
                    parameters: .init(
                        keyword: keyword,
                        page: page
                    )
                )
            )

            return translator.translate(entity)
        } catch {
            throw APIError.parse(error).asAppError
        }
    }
}
