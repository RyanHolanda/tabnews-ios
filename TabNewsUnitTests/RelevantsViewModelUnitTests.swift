import Cuckoo
@testable import TabNews
import XCTest

@MainActor
final class RelevantsViewModelTests: XCTestCase {
    var sut: RelevantsViewModel?
    var contentRepository: MockContentRepository?

    override func setUp() async throws {
        contentRepository = MockContentRepository()

        stub(contentRepository!) { stub in
            when(stub.getRelevantsPosts(page: any(), perPage: any()))
                .thenReturn([ContentPreviewDTO.fixture()])
        }

        sut = .init(repository: contentRepository!)
    }

    func testPaginateData() async throws {
        await sut!.paginateData()
        verify(contentRepository!, times(1)).getRelevantsPosts(page: 2, perPage: 20).with(returnType: [ContentPreviewDTO].self)
        await sut!.paginateData()
        verify(contentRepository!, times(1)).getRelevantsPosts(page: 3, perPage: 20).with(returnType: [ContentPreviewDTO].self)

        XCTAssert(sut!.posts.count == 2)
    }

    func testPaginateDataError() async throws {
        // When an error occur while paginating, and try to paginate again, should fetch the same page
        stub(contentRepository!) { stub in
            when(stub.getRelevantsPosts(page: any(), perPage: any()))
                .thenThrow(HTTP.HTTPError.invalidUrl)
        }
        await sut!.paginateData()
        await sut!.paginateData()

        verify(contentRepository!, times(2)).getRelevantsPosts(page: 2, perPage: 20).with(returnType: [ContentPreviewDTO].self)
    }

    func testPaginateDataFinished() async throws {
        // When returns less items than the per page, should set a variable to say the pagination items finished
        stub(contentRepository!) { stub in
            when(stub.getRelevantsPosts(page: any(), perPage: any()))
                .thenReturn([ContentPreviewDTO.fixture()])
        }

        await sut!.paginateData()
        XCTAssert(!sut!.hasMoreItems)
    }

    func testRefreshPosts() async throws {
        await sut!.refreshPosts()

        verify(contentRepository!, times(1)).getRelevantsPosts(page: 1, perPage: 20).with(returnType: [ContentPreviewDTO].self)
    }

    func testRefreshPostsError() async throws {
        stub(contentRepository!) { stub in
            when(stub.getRelevantsPosts(page: any(), perPage: any()))
                .thenThrow(HTTP.HTTPError.invalidUrl)
        }

        await sut!.refreshPosts()

        verify(contentRepository!, times(1)).getRelevantsPosts(page: 1, perPage: 20).with(returnType: [ContentPreviewDTO].self)
        XCTAssert(sut!.state == .error)
    }
}
