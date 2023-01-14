import Foundation
import PackagePlugin

@main
struct RewriteChecksumCommandPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let tool = try context.tool(named: "swift-package-checksum-rewriter")
        let process = try Process.run(URL(fileURLWithPath: tool.path.string), arguments: arguments)
        process.waitUntilExit()
    }
}
