// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FigmaUI",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "FigmaUI",
            targets: ["FigmaUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.8.1"))
    ],
    targets: [
        .target(
            name: "FigmaUI",
            dependencies: ["Kingfisher"]),
        .testTarget(
            name: "FigmaUITests",
            dependencies: ["FigmaUI"]),
    ]
)
