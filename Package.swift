// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MuHand",
    platforms: [.iOS(.v15), .visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MuHand",
            targets: ["MuHand"]),
    ],
    dependencies: [
        .package(url: "https://github.com/musesum/MuExtensions.git", branch: "main"),
        .package(url: "https://github.com/musesum/MuFlo.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MuHand",
            dependencies: [
                .product(name: "MuExtensions", package: "MuExtensions"),
                .product(name: "MuFlo", package: "MuFlo")]),
        .testTarget(
            name: "MuHandTests",
            dependencies: ["MuHand"]),
    ]
)
