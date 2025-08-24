// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Extension

extension Target {
    private var dependency: Target.Dependency {
        .target(
            name: name,
            condition: nil
        )
    }

    fileprivate func library(targets: [Target] = []) -> Product {
        .library(
            name: name,
            targets: [name] + targets.map(\.name)
        )
    }

    static func target(
        name: String,
        dependencies: [Target] = [],
        dependenciesLibraries: [Target.Dependency] = [],
        resources: [Resource] = []
    ) -> Target {
        .target(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            resources: resources
        )
    }

    static func testTarget(
        name: String,
        dependencies: [Target],
        dependenciesLibraries: [Target.Dependency] = [],
        resources: [Resource] = []
    ) -> Target {
        .testTarget(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            resources: resources
        )
    }
}

extension Package {
    static func package(
        name: String,
        defaultLocalization: LanguageTag = "ja",
        platforms: [SupportedPlatform],
        dependencies: [Dependency] = [],
        targets: [Target],
        testTargets: [Target]
    ) -> Package {
        .init(
            name: name,
            defaultLocalization: defaultLocalization,
            platforms: platforms,
            products: targets.map { $0.library() },
            dependencies: dependencies,
            targets: targets + testTargets
        )
    }
}

// MARK: - Library

let firebaseAnalytics = Target.Dependency.product(
    name: "FirebaseAnalytics",
    package: "firebase-ios-sdk"
)

let firebaseCrashlytics = Target.Dependency.product(
    name: "FirebaseCrashlytics",
    package: "firebase-ios-sdk"
)

let ohHttpStubs = Target.Dependency.product(
    name: "OHHTTPStubsSwift",
    package: "OHHTTPStubs"
)

// MARK: - Package

let appConfiguration = Target.target(
    name: "AppConfiguration"
)

let appExtension = Target.target(
    name: "AppExtension"
)

let appFeature = Target.target(
    name: "AppFeature",
    dependencies: [
        appConfiguration,
        appExtension
    ]
)

let appFirebase = Target.target(
    name: "AppFirebase",
    dependencies: [
        appFeature
    ],
    dependenciesLibraries: [
        firebaseAnalytics,
        firebaseCrashlytics
    ]
)

let appUI = Target.target(
    name: "AppUI",
    dependencies: [
        appFeature
    ]
)

let viewComponent = Target.target(
    name: "ViewComponent",
    dependencies: [
        appUI
    ]
)

let appDebug = Target.target(
    name: "AppDebug",
    dependencies: [
        viewComponent
    ]
)

let apiClient = Target.target(
    name: "APIClient"
)

let mockolo = Target.target(
    name: "Mockolo",
    dependencies: [
        apiClient
    ]
)

// MARK: - Test Package

let apiClientTests = Target.testTarget(
    name: "APIClientTests",
    dependencies: [
        apiClient
    ],
    dependenciesLibraries: [
        ohHttpStubs
    ],
    resources: [
        .process("JSON")
    ]
)

let appConfiugrationTests = Target.testTarget(
    name: "AppConfigurationTests",
    dependencies: [
        appConfiguration
    ]
)

let appExtensionTests = Target.testTarget(
    name: "AppExtensionTests",
    dependencies: [
        appExtension
    ]
)

let appFeatureTests = Target.testTarget(
    name: "AppFeatureTests",
    dependencies: [
        appFeature
    ]
)

// MARK: - Target

let package = Package.package(
    name: "Package",
    platforms: [
        .iOS(.v17)
    ],
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            from: "11.15.0"
        ),
        .package(
            url: "https://github.com/AliSoftware/OHHTTPStubs",
            from: "9.1.0"
        )
    ],
    targets: [
        apiClient,
        appConfiguration,
        appDebug,
        appExtension,
        appFeature,
        appFirebase,
        appUI,
        mockolo,
        viewComponent
    ],
    testTargets: [
        apiClientTests,
        appConfiugrationTests,
        appExtensionTests,
        appFeatureTests
    ]
)
