// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "AutoInitMacro",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .macCatalyst(.v18)
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
            from: "602.0.0"
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
