import MarkdownUI
import SwiftUI

extension MarkdownUI.Theme {
    static let custom: Theme = .init()
        .heading6(body: { config in
            config.label.bold()
                .markdownTextStyle {
                    FontSize(16)
                }
        })
        .heading5(body: { config in
            config.label.bold()
                .markdownTextStyle {
                    FontSize(16)
                }
        })
        .heading4(body: { config in
            config.label.bold()
                .markdownTextStyle {
                    FontSize(16)
                }
        })
        .heading3(body: { config in
            config.label.bold()
                .markdownTextStyle {
                    FontSize(18)
                }
        })
        .heading2(body: { config in
            config.label.bold()
                .markdownTextStyle {
                    FontSize(20)
                }
        })
        .heading1(body: { config in
            config.label.bold()
                .markdownTextStyle {
                    FontSize(22)
                }
        })
        .paragraph { config in
            config.label.markdownTextStyle {
                FontSize(15)
            }
        }
        .code {
            FontFamilyVariant(.monospaced)
            BackgroundColor(Color(.secondarySystemBackground))
        }
        .codeBlock { config in
            ScrollView(.horizontal) {
                config.label
                    .relativeLineSpacing(.em(0.25))
                    .markdownTextStyle {
                        FontFamilyVariant(.monospaced)
                        FontSize(.em(0.85))
                    }
                    .padding()
            }
            .scrollBounceBehavior(.basedOnSize)
            .accessibilityIdentifier("code-block-scroll-view")
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .markdownMargin(top: .em(0.8), bottom: .em(0.8))
        }
}
