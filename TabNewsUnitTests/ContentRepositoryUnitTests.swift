import Cuckoo
@testable import TabNews
import XCTest

final class ContentRepositoryTest: XCTestCase {
    var sut: ContentRepository?
    var http: MockHTTPProtocol?
    override func setUpWithError() throws {
        http = MockHTTPProtocol()
        sut = ContentDataRepository(http: http!)
    }

    func testGetRecentsPosts() async throws {
        stub(http!) { stub in
            when(stub.get<[ContentPreviewDTO]>(any()))
                .thenReturn([ContentPreviewDTO.fixture()])
        }
        let _: [ContentPreviewDTO] = try await sut!.getRecentsPosts(page: 1, perPage: 2)

        verify(http!, times(1)).get<[ContentPreviewDTO]>("/contents?page=1&per_page=2&strategy=new")
            .with(returnType: [ContentPreviewDTO].self)
    }

    func testGetRelevantsPosts() async throws {
        stub(http!) { stub in
            when(stub.get<[ContentPreviewDTO]>(any()))
                .thenReturn([ContentPreviewDTO.fixture()])
        }
        let _: [ContentPreviewDTO] = try await sut!.getRelevantsPosts(page: 1, perPage: 2)

        verify(http!, times(1)).get<[ContentPreviewDTO]>("/contents?page=1&per_page=2&strategy=relevant")
            .with(returnType: [ContentPreviewDTO].self)
    }

    func testGetPost() async throws {
        stub(http!) { stub in
            when(stub.get("/contents/username/s-l-u-g"))
                .thenReturn(ContentDTO.fixture())
        }

        let _: ContentDTO = try await sut!.getPost(ownerUsername: "username", slug: "s-l-u-g")

        verify(http!, times(1)).get<ContentDTO>("/contents/username/s-l-u-g").with(returnType: ContentDTO.self)
    }
}
