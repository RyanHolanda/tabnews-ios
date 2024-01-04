import Foundation

enum PreviewMocks {
    class MockUserRepository: UserRepository {
        func getUser(username _: String) async throws -> UserDto {
            UserDto.fixture()
        }
    }

    class MockContentRepository: ContentRepository {
        func getComment(ownerUsername _: String, slug _: String) async throws -> CommentDTO {
            CommentDTO.fixture()
        }

        func getComments(ownerUsername _: String, slug _: String) async throws -> [CommentDTO] {
            [
                CommentDTO.fixture()
                    .copyWith(replies: 2)
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
