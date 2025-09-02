import AppFeature
import FirebaseAnalytics

public struct FirebaseAnalytics: FirebaseAnalyzable {
    public var screenID: FirebaseAnalyticsScreenID

    public init(screenID: FirebaseAnalyticsScreenID) {
        self.screenID = screenID
    }

    public func sendEvent(_ event: FirebaseAnalyticsEvent) {
        var params = event.parameters
        params["スクリーンID"] = screenID.value

        let parameters = params.mapValues {
            $0 is String
                ? ($0 as! String).prefix(100)
                : $0
        }

        Analytics.logEvent(
            event.name,
            parameters: parameters
        )

        Logger.firebase(event: event)
    }
}
