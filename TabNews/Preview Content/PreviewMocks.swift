import Foundation

class PreviewMocks {
    class MockContentRepository: ContentRepository {
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
