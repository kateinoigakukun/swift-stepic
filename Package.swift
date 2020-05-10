// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftStepic",
    products: [
        .executable(name: "swift-stepic", targets: ["SwiftStepic"])
    ],
    dependencies: [
        .package(name: "swift-argument-parser", url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(name: "SwiftImage", url: "https://github.com/koher/swift-image", from: "0.7.1"),
    ],
    targets: [
        .target(
            name: "SwiftStepic",
            dependencies: [
                .target(name: "SwiftStepicKit"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(
            name: "SwiftStepicKit",
            dependencies: [
                .product(name: "SwiftImage", package: "SwiftImage"),
            ]),
        .testTarget(
            name: "SwiftStepicKitTests",
            dependencies: ["SwiftStepicKit"]),
    ]
)
