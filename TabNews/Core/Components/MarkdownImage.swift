import MarkdownUI
import SwiftUI

private extension View {
    var asUIImage: UIImage {
        let controller: UIHostingController = .init(rootView: self)
        let view: UIView = controller.view

        let targetSize: CGSize = controller.view.intrinsicContentSize
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.backgroundColor = .clear

        let renderer: UIGraphicsImageRenderer = .init(size: targetSize)

        return renderer.image { _ in
            view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct MarkdownImage: ImageProvider {
    var onTapSaveImage: (_ image: UIImage) -> Void

    func makeImage(url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .contextMenu {
                    Button {
                        onTapSaveImage(image.asUIImage)
                    } label: {
                        Label(String(localized: .localizable.saveImage), systemImage: "arrow.down.circle.dotted")
                    }
                    Button {
                        UIPasteboard.general.image = image.asUIImage
                    } label: {
                        Label(String(localized: .localizable.copyImage), systemImage: "doc.on.doc")
                    }
                    ShareLink(item: image, preview: SharePreview("", image: image, icon: image)) {
                        Label(String(localized: .localizable.shareImage), systemImage: "square.and.arrow.up")
                    }
                }
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, idealHeight: 100, alignment: .center)
        }
    }
}
