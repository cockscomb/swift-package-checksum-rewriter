// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-package-checksum-rewriter",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.1"),
        .package(url: "https://github.com/apple/swift-syntax.git", exact: "0.50700.0"),
    ],
    targets: [
        .executableTarget(
            name: "swift-package-checksum-rewriter",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxParser", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),

            ]),
        .testTarget(
            name: "swift-package-checksum-rewriterTests",
            dependencies: ["swift-package-checksum-rewriter"]),
    ]
)
