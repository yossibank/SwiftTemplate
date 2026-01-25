// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "BuilderMacro",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .macCatalyst(.v18)
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
            from: "602.0.0"
        )
    ],
    targets: [
        .macro(
            name: "BuilderMacroMacros",
            dependencies: [
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftCompilerPlugin",
                    package: "swift-syntax"
                )
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
