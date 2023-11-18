import Foundation

enum PreviewMocks {
    class MockContentRepository: ContentRepository {
        func getComments(ownerUsername _: String, slug _: String) async throws -> [CommentDTO] {
            [
                CommentDTO.fixture()
            ]
        }

        func getPost(ownerUsername _: String, slug _: String) async throws -> ContentDTO {
            ContentDTO.fixture()
        }

        func getRelevantsPosts(page _: Int, perPage _: Int) async throws -> [ContentPreviewDTO] {
            [ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture()]
        }

        func getRecentsPosts(page _: Int, perPage _: Int) async throws -> [ContentPreviewDTO] {
            [ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture(),
             ContentPreviewDTO.fixture()]
        }
    }
}
