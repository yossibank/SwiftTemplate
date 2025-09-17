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

// MARK: - Marco

// Swift SyntaxをPreBuild → defaults write com.apple.dt.Xcode IDEPackageEnablePrebuilts YES

let builderMacro = Target.Dependency.product(
    name: "BuilderMacro",
    package: "BuilderMacro"
)

let urlMacro = Target.Dependency.product(
    name: "URLMacro",
    package: "URLMacro"
)

// MARK: - Package

let appExtension = Target.target(
    name: "AppExtension",
    path: "./Sources/Core/AppExtension"
)

let appFoundation = Target.target(
    name: "AppFoundation",
    dependencies: [
        appExtension
    ],
    path: "./Sources/Core/AppFoundation"
)

let viewComponent = Target.target(
    name: "ViewComponent",
    dependencies: [
        appFoundation
    ],
    path: "./Sources/Core/ViewComponent"
)

let viewEnvironment = Target.target(
    name: "ViewEnvironment",
    path: "./Sources/Core/ViewEnvironment"
)

let debugMenu = Target.target(
    name: "DebugMenu",
    dependencies: [
        viewComponent
    ],
    dependenciesLibraries: [
        urlMacro
    ],
    path: "./Sources/Core/DebugMenu"
)

let firebaseLive = Target.target(
    name: "FirebaseLive",
    dependencies: [
        appFoundation
    ],
    dependenciesLibraries: [
        firebaseAnalytics,
        firebaseCrashlytics
    ],
    path: "./Sources/Core/Firebaselive"
)

let apiClient = Target.target(
    name: "APIClient",
    dependencies: [
        appFoundation,
        debugMenu
    ],
    path: "./Sources/Core/APIClient"
)

let rakutenView = Target.target(
    name: "RakutenView",
    dependencies: [
        appFoundation,
        viewComponent,
        viewEnvironment
    ],
    dependenciesLibraries: [
        builderMacro
    ],
    path: "./Sources/Feature/RakutenView"
)

let rakutenDetailView = Target.target(
    name: "RakutenDetailView",
    dependencies: [
        appFoundation,
        viewComponent,
        viewEnvironment
    ],
    path: "./Sources/Feature/RakutenDetailView"
)

let rakuten = Target.target(
    name: "Rakuten",
    dependencies: [
        apiClient,
        firebaseLive,
        rakutenDetailView,
        rakutenView
    ],
    dependenciesLibraries: [
        builderMacro
    ],
    path: "./Sources/Feature/Rakuten"
)

let core = [
    apiClient,
    appExtension,
    appFoundation,
    debugMenu,
    viewComponent,
    viewEnvironment
]

let feature = [
    rakuten,
    rakutenDetailView,
    rakutenView
]

let appEnvironment = Target.target(
    name: "AppEnvironment",
    dependencies: core + feature,
    path: "./Sources/App/AppEnvironment"
)

let debug = Target.target(
    name: "DebugApp",
    dependencies: core + feature + [appEnvironment],
    path: "./Sources/App/Root/Debug"
)

let staging = Target.target(
    name: "StagingApp",
    dependencies: core + feature + [appEnvironment],
    path: "./Sources/App/Root/Staging"
)

let release = Target.target(
    name: "ReleaseApp",
    dependencies: core + feature + [appEnvironment],
    path: "./Sources/App/Root/Release"
)

let mockolo = Target.target(
    name: "Mockolo",
    dependencies: [
        apiClient,
        firebaseLive,
        rakuten
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

let appFoundationTests = Target.testTarget(
    name: "AppFoundationTests",
    dependencies: [
        appFoundation
    ],
    path: "./Tests/Core/AppFoundationTests"
)

let rakutenTests = Target.testTarget(
    name: "RakutenTests",
    dependencies: [
        rakuten,
        mockolo
    ],
    dependenciesLibraries: [
        builderMacro
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
            from: "12.3.0"
        ),
        .package(
            url: "https://github.com/AliSoftware/OHHTTPStubs",
            from: "9.1.0"
        ),
        .package(path: "../Macro/BuilderMacro"),
        .package(path: "../Macro/URLMacro")
    ],
    targets: [
        apiClient,
        appExtension,
        appFoundation,
        debugMenu,
        firebaseLive,
        viewComponent,
        viewEnvironment,
        rakuten,
        rakutenDetailView,
        rakutenView,
        appEnvironment,
        debug,
        staging,
        release,
        mockolo
    ],
    testTargets: [
        apiClientTests,
        appExtensionTests,
        appFoundationTests,
        rakutenTests
    ]
)
