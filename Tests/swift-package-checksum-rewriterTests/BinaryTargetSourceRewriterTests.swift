import XCTest
import SwiftSyntaxParser
@testable import swift_package_checksum_rewriter

final class BinaryTargetSourceRewriterTests: XCTestCase {
    func testRewrite() throws {
        for (source, expected) in testcases {
            let source = try SyntaxParser.parse(source: source)
            let rewriter = BinaryTargetSourceRewriter(
                name: "GOJQBinding",
                source: BinaryTargetSource(
                    url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.1/GOJQBinding.xcframework.zip",
                    checksum: "d67b90b83d06ca9a8a1a4f25c561e5c78628bd05a9eca5f413eb032c66d8786a"
                )
            )
            XCTAssertEqual(String(describing: rewriter.visit(source)), expected)
        }
    }
}

fileprivate let testcases: [(String, String)] = [
    (
        """
        // swift-tools-version: 5.7

        import PackageDescription

        let package = Package(
            name: "SwiftGoJq",
            platforms: [
                .macOS(.v13),
                .macCatalyst(.v14),
                .iOS(.v14),
            ],
            products: [
                .library(
                    name: "SwiftGoJq",
                    targets: ["SwiftGoJq"]),
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
            ],
            targets: [
                .binaryTarget(
                    name: "GOJQBinding",
                    url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.0/GOJQBinding.xcframework.zip",
                    checksum: "1c45710de17fb7020dcfc75105344729725c5e3875e7058e98790e5f4e178162"),
                .target(
                    name: "SwiftGoJq",
                    dependencies: [
                        "GOJQBinding",
                    ]),
            ]
        )
        """,
        """
        // swift-tools-version: 5.7

        import PackageDescription

        let package = Package(
            name: "SwiftGoJq",
            platforms: [
                .macOS(.v13),
                .macCatalyst(.v14),
                .iOS(.v14),
            ],
            products: [
                .library(
                    name: "SwiftGoJq",
                    targets: ["SwiftGoJq"]),
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
            ],
            targets: [
                .binaryTarget(
                    name: "GOJQBinding",
                    url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.1/GOJQBinding.xcframework.zip",
                    checksum: "d67b90b83d06ca9a8a1a4f25c561e5c78628bd05a9eca5f413eb032c66d8786a"),
                .target(
                    name: "SwiftGoJq",
                    dependencies: [
                        "GOJQBinding",
                    ]),
            ]
        )
        """
    ),
    (
        """
        // swift-tools-version: 5.7

        import PackageDescription

        let package = Package(
            name: "SwiftGoJq",
            platforms: [
                .macOS(.v13),
                .macCatalyst(.v14),
                .iOS(.v14),
            ],
            products: [
                .library(
                    name: "SwiftGoJq",
                    targets: ["SwiftGoJq"]),
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
            ],
            targets: [
                .binaryTarget(name: "GOJQBinding", url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.0/GOJQBinding.xcframework.zip", checksum: "1c45710de17fb7020dcfc75105344729725c5e3875e7058e98790e5f4e178162"),
                .target(
                    name: "SwiftGoJq",
                    dependencies: [
                        "GOJQBinding",
                    ]),
            ]
        )
        """,
        """
        // swift-tools-version: 5.7

        import PackageDescription

        let package = Package(
            name: "SwiftGoJq",
            platforms: [
                .macOS(.v13),
                .macCatalyst(.v14),
                .iOS(.v14),
            ],
            products: [
                .library(
                    name: "SwiftGoJq",
                    targets: ["SwiftGoJq"]),
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
            ],
            targets: [
                .binaryTarget(name: "GOJQBinding", url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.1/GOJQBinding.xcframework.zip", checksum: "d67b90b83d06ca9a8a1a4f25c561e5c78628bd05a9eca5f413eb032c66d8786a"),
                .target(
                    name: "SwiftGoJq",
                    dependencies: [
                        "GOJQBinding",
                    ]),
            ]
        )
        """
    ),
    (
        """
        // swift-tools-version: 5.7

        import PackageDescription

        let package = Package(
            name: "SwiftGoJq",
            platforms: [
                .macOS(.v13),
                .macCatalyst(.v14),
                .iOS(.v14),
            ],
            products: [
                .library(
                    name: "SwiftGoJq",
                    targets: ["SwiftGoJq"]),
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
            ],
            targets: [
                .binaryTarget(
                    name: "GOJQBinding",
                    path: "Frameworks/GOJQBinding.xcframework"),
                .target(
                    name: "SwiftGoJq",
                    dependencies: [
                        "GOJQBinding",
                    ]),
            ]
        )
        """,
        """
        // swift-tools-version: 5.7

        import PackageDescription

        let package = Package(
            name: "SwiftGoJq",
            platforms: [
                .macOS(.v13),
                .macCatalyst(.v14),
                .iOS(.v14),
            ],
            products: [
                .library(
                    name: "SwiftGoJq",
                    targets: ["SwiftGoJq"]),
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
            ],
            targets: [
                .binaryTarget(
                    name: "GOJQBinding",
                    url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.1/GOJQBinding.xcframework.zip",
                    checksum: "d67b90b83d06ca9a8a1a4f25c561e5c78628bd05a9eca5f413eb032c66d8786a"),
                .target(
                    name: "SwiftGoJq",
                    dependencies: [
                        "GOJQBinding",
                    ]),
            ]
        )
        """
    ),
    (
        """
        // swift-tools-version: 5.7

        import PackageDescription

        let package = Package(
            name: "SwiftGoJq",
            platforms: [
                .macOS(.v13),
                .macCatalyst(.v14),
                .iOS(.v14),
            ],
            products: [
                .library(
                    name: "SwiftGoJq",
                    targets: ["SwiftGoJq"]),
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
            ],
            targets: [
                .binaryTarget(name: "GOJQBinding", path: "Frameworks/GOJQBinding.xcframework"),
                .target(
                    name: "SwiftGoJq",
                    dependencies: [
                        "GOJQBinding",
                    ]),
            ]
        )
        """,
        """
        // swift-tools-version: 5.7

        import PackageDescription

        let package = Package(
            name: "SwiftGoJq",
            platforms: [
                .macOS(.v13),
                .macCatalyst(.v14),
                .iOS(.v14),
            ],
            products: [
                .library(
                    name: "SwiftGoJq",
                    targets: ["SwiftGoJq"]),
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
            ],
            targets: [
                .binaryTarget(name: "GOJQBinding", url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.1/GOJQBinding.xcframework.zip", checksum: "d67b90b83d06ca9a8a1a4f25c561e5c78628bd05a9eca5f413eb032c66d8786a"),
                .target(
                    name: "SwiftGoJq",
                    dependencies: [
                        "GOJQBinding",
                    ]),
            ]
        )
        """
    ),
]
