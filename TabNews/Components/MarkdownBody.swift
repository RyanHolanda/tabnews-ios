import MarkdownUI
import SwiftUI

struct MarkdownBody: View {
    init(_ content: String) {
        self.content = content
    }

    let content: String

    var body: some View {
        Markdown(content)
            .markdownTheme(.custom)
            .textSelection(.enabled)
    }
}

#Preview {
    MarkdownBody("# Markdown")
}
