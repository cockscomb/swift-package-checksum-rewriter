import Foundation
import ArgumentParser
import SwiftSyntaxParser

@main
struct RewritePackageBinaryTarget: ParsableCommand {
    @Option(help: "URL of binary.")
    var url: String

    @Option(help: "Checksum of binary.")
    var checksum: String

    @Argument(help: "Path to Package.swift file.", transform: URL.init(fileURLWithPath:))
    var packageSwift: URL

    @Argument(help: "Name of binaryTarget.")
    var name: String

    mutating func validate() throws {
        guard FileManager.default.fileExists(atPath: packageSwift.path) else {
            throw ValidationError("File does not exist at \(packageSwift.path)")
        }
    }

    mutating func run() throws {
        let source = try SyntaxParser.parse(packageSwift)
        let rewriter = BinaryTargetSourceRewriter(
            name: name,
            source: BinaryTargetSource(
                url: url,
                checksum: checksum
            )
        )
        try String(describing: rewriter.visit(source))
            .write(to: packageSwift, atomically: true, encoding: .utf8)
    }
}
