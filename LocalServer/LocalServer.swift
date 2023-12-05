import Foundation
import Swifter

class LocalServer {
    private let server: HttpServer = .init()
    deinit { server.stop() }

    func getPort() -> Int? {
        try? server.port()
    }

    func run() {
        setRoutes()
        try? server.start(8080)
    }

    private func setRoutes() {
        server["/contents/:ownerUsername/:slug/children"] = { _ in .ok(.json(CommentResponses.commentsWithReplies)) }
        server["/contents"] = { _ in .ok(.json(ContentsReponses.RelevantsList)) }
        server["/contents/:ownerUsername/:slug"] = { _ in .ok(.json(ContentResponses.longBody)) }
    }
}
