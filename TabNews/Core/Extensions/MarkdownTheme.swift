import Foundation
import MarkdownUI

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
}
