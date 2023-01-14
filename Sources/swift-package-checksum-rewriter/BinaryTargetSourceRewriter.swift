import SwiftSyntax
import SwiftSyntaxBuilder

struct BinaryTargetSource {
    let url: String
    let checksum: String
}

class BinaryTargetSourceRewriter: SyntaxRewriter {
    private let name: String
    private let source: BinaryTargetSource

    init(name: String, source: BinaryTargetSource) {
        self.name = name
        self.source = source
    }

    override func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
        guard
            let memberAccessExpr = node.children.first?.as(MemberAccessExprSyntax.self),
            memberAccessExpr.name.text == "binaryTarget",
            let nameArgument = node.argumentList.first(where: { $0.label?.text == "name" }),
            let stringLiteral = nameArgument.expression.as(StringLiteralExprSyntax.self),
            stringLiteral.segments.firstToken?.text == name
        else {
            return super.visit(node)
        }

        let urlArgument = node.argumentList.first(where: { $0.label?.text == "url" })
        let checksumArgument = node.argumentList.first(where: { $0.label?.text == "checksum" })

        let arguments = SyntaxFactory.makeTupleExprElementList([
            SyntaxFactory.makeTupleExprElement(
                label: .identifier("name"),
                colon: .colon,
                expression: StringLiteralExpr(name).buildExpr(format: Format()),
                trailingComma: .comma
            )
            .withLeadingTrivia(nameArgument.leadingTrivia ?? .zero)
            .withTrailingTrivia(nameArgument.trailingTrivia ?? .spaces(1)),
            SyntaxFactory.makeTupleExprElement(
                label: .identifier("url"),
                colon: .colon,
                expression: StringLiteralExpr(source.url).buildExpr(format: Format()),
                trailingComma: .comma
            )
            .withLeadingTrivia(urlArgument?.leadingTrivia ?? nameArgument.leadingTrivia ?? .zero)
            .withTrailingTrivia(urlArgument?.trailingTrivia ?? nameArgument.trailingTrivia ?? .spaces(1)),
            SyntaxFactory.makeTupleExprElement(
                label: .identifier("checksum"),
                colon: .colon,
                expression: StringLiteralExpr(source.checksum).buildExpr(format: Format()),
                trailingComma: nil
            )
            .withLeadingTrivia(checksumArgument?.leadingTrivia ?? nameArgument.leadingTrivia ?? .zero)
            .withTrailingTrivia(checksumArgument?.trailingTrivia ?? .zero),
        ])
        return ExprSyntax(node.withArgumentList(arguments))
    }
}
