import Foundation
import Swifter

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
        server["/contents/:ownerUsername/:slug/children"] = { _ in .ok(.json(CommentResponses.commentsWithReplies)) }
        server["/contents"] = { _ in .ok(.json(ContentsReponses.RelevantsList)) }
        server["/contents/:ownerUsername/:slug"] = { _ in .ok(.json(ContentResponses.longBody)) }
    }
}
