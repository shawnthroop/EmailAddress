// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmailAddress",
    products: [
        .library(name: "EmailAddress", targets: ["EmailAddress"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "EmailAddress", path: "Sources"),
        .testTarget(name: "EmailAddressTests", dependencies: ["EmailAddress"]),
    ]
)
