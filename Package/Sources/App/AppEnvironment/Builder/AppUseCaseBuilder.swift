import APIClient
import Rakuten

public enum AppUseCaseBuilder {
    public static func rakuten() -> RakutenUseCase {
        .init(
            apiClient: APIClient(),
            translator: RakutenTranslator()
        )
    }
}
