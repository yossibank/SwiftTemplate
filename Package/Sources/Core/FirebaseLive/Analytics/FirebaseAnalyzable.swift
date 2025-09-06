import AppFoundation

/// @mockable
public protocol FirebaseAnalyzable: Sendable {
    var screenID: FirebaseAnalyticsScreenID { get }

    func sendEvent(_ event: FirebaseAnalyticsEvent)
}
