// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "AutoInitMacro",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .macCatalyst(.v16)
    ],
    products: [
        .library(
            name: "AutoInitMacro",
            targets: ["AutoInitMacro"]
        ),
        .executable(
            name: "AutoInitMacroClient",
            targets: ["AutoInitMacroClient"]
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
            name: "AutoInitMacroMacros",
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
            name: "AutoInitMacro",
            dependencies: ["AutoInitMacroMacros"]
        ),
        .executableTarget(
            name: "AutoInitMacroClient",
            dependencies: ["AutoInitMacro"]
        ),
        .testTarget(
            name: "AutoInitMacroTests",
            dependencies: [
                "AutoInitMacroMacros",
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                )
            ]
        )
    ]
)
