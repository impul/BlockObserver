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
    dependencies: [],
    targets: [
        .target(
            name: "BlockObserver",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "BlockObserverTests",
            dependencies: ["BlockObserver"],
            path: "Tests")
    ]
)
