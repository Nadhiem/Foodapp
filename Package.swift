// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalorieApp",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .executable(name: "CalorieApp", targets: ["CalorieApp"])
    ],
    targets: [
        .executableTarget(
            name: "CalorieApp",
            path: "Sources/CalorieApp"
        )
    ]
)
