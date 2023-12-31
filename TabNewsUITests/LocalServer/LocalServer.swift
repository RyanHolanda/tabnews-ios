import Foundation
import Swifter
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

class LocalServer {
    static let shared: LocalServer = .init()
    let server: HttpServer = .init()

    deinit { stop() }

    func stop() {
        server.stop()
    }

    func run() {
        if server.operating { return }
        setRoutes()
        try? server.start(8080, priority: .userInitiated)
    }

    private func setRoutes() {
        let image: Data = Text("Mock Image")
            .frame(width: 300, height: 200)
            .background(.blue)
            .asUIImage.pngData()!

        server["/contents/:ownerUsername/:slug/children"] = { _ in .ok(.json(CommentResponses.commentsWithReplies)) }
        server["/contents"] = { _ in .ok(.json(ContentsReponses.RelevantsList)) }
        server["/contents/:ownerUsername/:slug"] = { _ in .ok(.json(ContentResponses.longBody)) }
        server["/image"] = { _ in .ok(.data(image, contentType: "image/png")) }
    }
}
