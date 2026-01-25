// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "URLMacro",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .macCatalyst(.v18)
    ],
    products: [
        .library(
            name: "URLMacro",
            targets: ["URLMacro"]
        ),
        .executable(
            name: "URLMacroClient",
            targets: ["URLMacroClient"]
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
            name: "URLMacroMacros",
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
            name: "URLMacro",
            dependencies: ["URLMacroMacros"]
        ),
        .executableTarget(
            name: "URLMacroClient",
            dependencies: ["URLMacro"]
        ),
        .testTarget(
            name: "URLMacroTests",
            dependencies: [
                "URLMacroMacros",
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                )
            ]
        )
    ]
)
