import AppFeature

/// @mockable
public protocol FirebaseAnalyzable {
    var screenID: FirebaseAnalyticsScreenID { get }

    func sendEvent(_ event: FirebaseAnalyticsEvent)
}
