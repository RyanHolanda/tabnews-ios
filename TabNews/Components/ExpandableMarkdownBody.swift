import MarkdownUI
import SwiftUI

struct ExpandableMarkdownBody: View {
    init(_ content: String) {
        self.content = content
    }

    let content: String
    @State private var isExpanded: Bool = false
    @State var contentHeight: Double = 0

    var body: some View {
        VStack(alignment: .trailing) {
            ScrollView {
                MarkdownBody(content)
                    .overlay(
                        GeometryReader(content: { proxy in
                            Color.clear
                                .onAppear {
                                    self.contentHeight = proxy.size.height
                                    if contentHeight < 150 {
                                        isExpanded = true
                                    }
                                }
                        })
                    )
            }
            .scrollDisabled(true)
            .frame(maxHeight: isExpanded ? contentHeight : 140)
            .animation(.snappy, value: !isExpanded)
            .overlay {
                LinearGradient(
                    gradient: Gradient(colors: [!isExpanded ? .init(light: .white, dark: .black) : .clear, Color.clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )

                .frame(maxHeight: contentHeight, alignment: .bottom)
            }
            .animation(.snappy, value: !isExpanded)

            if !isExpanded {
                Button(String(localized: .localizable.seeMore)) {
                    isExpanded = true
                }
                .font(.caption)
                .bold()
            }
        }
    }
}

#Preview {
    ExpandableMarkdownBody("Regular text")
}
