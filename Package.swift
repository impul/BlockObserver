// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlockObserver",
    products: [
        .library(
            name: "BlockObserver",
            targets: ["BlockObserver"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/console.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "BlockObserver",
            dependencies: ["Logging"],
            path: "Sources"),
        .testTarget(
            name: "BlockObserverTests",
            dependencies: ["BlockObserver", "Logging"],
            path: "Tests")
    ]
)
