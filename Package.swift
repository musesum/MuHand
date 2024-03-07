// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MuHand",
    platforms: [.iOS(.v15), .visionOS(.v1)],
    products: [
        .library(
            name: "MuHand",
            targets: ["MuHand"]),
    ],
    dependencies: [
        .package(url: "https://github.com/musesum/MuExtensions.git", branch: "main"),
        .package(url: "https://github.com/musesum/MuFlo.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "MuHand",
            dependencies: [
                .product(name: "MuExtensions", package: "MuExtensions"),
                .product(name: "MuFlo", package: "MuFlo")],
            resources: [.process("Resources")]),
        .testTarget(
            name: "MuHandTests",
            dependencies: ["MuHand"]),
    ]
)
