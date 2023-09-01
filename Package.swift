// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swift2D",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Swift2D",
            targets: ["Swift2D"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Swift2D"),
        .testTarget(
            name: "Swift2DTests",
            dependencies: ["Swift2D"]),
    ]
)
