// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AnvilMenuBar",
    platforms: [.macOS(.v15)],
    products: [
        .library(name: "AnvilMenuBar", targets: ["AnvilMenuBar"])
    ],
    targets: [
        .target(
            name: "AnvilMenuBar"
        ),
        .testTarget(
            name: "AnvilMenuBarTests",
            dependencies: ["AnvilMenuBar"]
        )
    ],
    swiftLanguageModes: [.v6]
)
