// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "NetworkKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "NetworkKit",
            targets: ["NetworkKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/liamnichols/xcstrings-tool-plugin.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "NetworkKit",
            resources: [
                .process("Resources/Localizable.xcstrings")
            ],
            plugins: [
                .plugin(name: "XCStringsToolPlugin", package: "xcstrings-tool-plugin")
            ]
        )
    ]
)
