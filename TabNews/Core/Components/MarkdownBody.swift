import MarkdownUI
import Photos
import SwiftUI

struct MarkdownBody: View {
    init(_ content: String) {
        self.content = content
    }

    @State private var showPhotosAccessAlert: Bool = false

    let content: String
    var body: some View {
        Markdown(content)
            .markdownImageProvider(MarkdownImage(onTapSaveImage: { image in
                PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                    guard status != .denied else { return showPhotosAccessAlert = true }
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }))
            .markdownTheme(.custom)
            .textSelection(.enabled)
            .alert(String(localized: .localizable.allowToSavePhotos), isPresented: $showPhotosAccessAlert) {
                Button(String(localized: .localizable.close)) { showPhotosAccessAlert = false }

                Link(String(localized: .localizable.openSettings), destination: URL(string: UIApplication.openSettingsURLString)!)

            } message: {
                Text(String(localized: .localizable.allowToSavePhotosDescription))
            }
    }
}

#Preview {
    MarkdownBody("# Markdown")
}
