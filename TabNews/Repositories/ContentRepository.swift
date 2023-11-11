import Foundation

protocol ContentRepository {
    func getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
    func getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
    func getPost(ownerUsername: String, slug: String) async throws -> ContentDTO
}

class ContentDataRepository: ContentRepository {
    init(http: HTTPProtocol) {
        self.http = http
    }

    let http: HTTPProtocol

    func getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO] {
        let posts: [ContentPreviewDTO] = try await http.get("/contents?page=\(page)&per_page=\(perPage)&strategy=new")
        return posts
    }

    func getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO] {
        let posts: [ContentPreviewDTO] = try await http.get("/contents?page=\(page)&per_page=\(perPage)&strategy=relevant")
        return posts
    }

    func getPost(ownerUsername: String, slug: String) async throws -> ContentDTO {
        let post: ContentDTO = try await http.get("/contents/\(ownerUsername)/\(slug)")

        return post
    }
}
