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
        path: String? = nil,
        resources: [Resource] = []
    ) -> Target {
        .target(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            path: path,
            resources: resources
        )
    }

    static func testTarget(
        name: String,
        dependencies: [Target],
        dependenciesLibraries: [Target.Dependency] = [],
        path: String? = nil,
        resources: [Resource] = []
    ) -> Target {
        .testTarget(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            path: path,
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
    name: "AppConfiguration",
    path: "./Sources/Core/AppConfiguration"
)

let appExtension = Target.target(
    name: "AppExtension",
    path: "./Sources/Core/AppExtension"
)

let appFeature = Target.target(
    name: "AppFeature",
    dependencies: [
        appConfiguration,
        appExtension
    ],
    path: "./Sources/Core/AppFeature"
)

let appFirebase = Target.target(
    name: "AppFirebase",
    dependencies: [
        appFeature
    ],
    dependenciesLibraries: [
        firebaseAnalytics,
        firebaseCrashlytics
    ],
    path: "./Sources/Core/AppFirebase"
)

let appUI = Target.target(
    name: "AppUI",
    dependencies: [
        appFeature
    ],
    path: "./Sources/Core/AppUI"
)

let viewComponent = Target.target(
    name: "ViewComponent",
    dependencies: [
        appUI
    ],
    path: "./Sources/Core/ViewComponent"
)

let appDebug = Target.target(
    name: "AppDebug",
    dependencies: [
        viewComponent
    ],
    path: "./Sources/Core/AppDebug"
)

let apiClient = Target.target(
    name: "APIClient",
    dependencies: [
        appDebug,
        appFeature
    ],
    path: "./Sources/Core/APIClient"
)

let rakuten = Target.target(
    name: "Rakuten",
    dependencies: [
        apiClient,
        appExtension
    ],
    path: "./Sources/Feature/Rakuten"
)

let rakutenView = Target.target(
    name: "RakutenView",
    dependencies: [
        viewComponent
    ],
    path: "./Sources/Feature/RakutenView"
)

let rakutenConnector = Target.target(
    name: "RakutenConnector",
    dependencies: [
        appFirebase,
        rakuten,
        rakutenView
    ],
    path: "./Sources/Feature/RakutenConnector"
)

let core = [
    apiClient,
    appConfiguration,
    appDebug,
    appExtension,
    appFeature,
    appUI,
    viewComponent
]

let feature = [
    rakuten,
    rakutenConnector,
    rakutenView
]

let environment = Target.target(
    name: "Environment",
    dependencies: core + feature,
    path: "./Sources/App/Environment"
)

let debug = Target.target(
    name: "DebugApp",
    dependencies: core + feature + [environment],
    path: "./Sources/App/Root/Debug"
)

let staging = Target.target(
    name: "StagingApp",
    dependencies: core + feature + [environment],
    path: "./Sources/App/Root/Staging"
)

let release = Target.target(
    name: "ReleaseApp",
    dependencies: core + feature + [environment],
    path: "./Sources/App/Root/Release"
)

let mockolo = Target.target(
    name: "Mockolo",
    dependencies: [
        apiClient,
        appFirebase,
        rakuten,
        rakutenConnector
    ],
    path: "./Mockolo"
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
    path: "./Tests/Core/APIClientTests",
    resources: [
        .process("JSON")
    ]
)

let appExtensionTests = Target.testTarget(
    name: "AppExtensionTests",
    dependencies: [
        appExtension
    ],
    path: "./Tests/Core/AppExtensionTests"
)

let appFeatureTests = Target.testTarget(
    name: "AppFeatureTests",
    dependencies: [
        appFeature
    ],
    path: "./Tests/Core/AppFeatureTests"
)

let rakutenConnectorTests = Target.testTarget(
    name: "RakutenConnectorTests",
    dependencies: [
        rakutenConnector,
        mockolo
    ],
    path: "./Tests/Feature/RakutenConnectorTests"
)

let rakutenTests = Target.testTarget(
    name: "RakutenTests",
    dependencies: [
        rakuten,
        mockolo
    ],
    path: "./Tests/Feature/RakutenTests"
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
        viewComponent,
        rakuten,
        rakutenConnector,
        rakutenView,
        environment,
        debug,
        staging,
        release,
        mockolo
    ],
    testTargets: [
        apiClientTests,
        appExtensionTests,
        appFeatureTests,
        rakutenConnectorTests,
        rakutenTests
    ]
)
