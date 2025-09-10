import FirebaseLive
import Rakuten
import RakutenView
import ViewEnvironment

@MainActor
public enum AppViewModelBuilder {
    public static func rakuten(_ environment: any ViewEnvironment) -> RakutenViewModel {
        .init(
            dependency: .init(
                useCase: AppUseCaseBuilder.rakuten(),
                converter: RakutenConverter(),
                analytics: FirebaseAnalytics(screenID: .search),
                environment: environment
            )
        )
    }
}
