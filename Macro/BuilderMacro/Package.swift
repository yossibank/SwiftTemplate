// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "BuilderMacro",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "BuilderMacro",
            targets: ["BuilderMacro"]
        ),
        .executable(
            name: "BuilderMacroClient",
            targets: ["BuilderMacroClient"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftlang/swift-syntax.git",
            from: "600.0.1"
        )
    ],
    targets: [
        .macro(
            name: "BuilderMacroMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(
            name: "BuilderMacro",
            dependencies: ["BuilderMacroMacros"]
        ),
        .executableTarget(
            name: "BuilderMacroClient",
            dependencies: ["BuilderMacro"]
        ),
        .testTarget(
            name: "BuilderMacroTests",
            dependencies: [
                "BuilderMacroMacros",
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                )
            ]
        )
    ]
)
