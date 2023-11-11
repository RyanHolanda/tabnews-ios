import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor
class ContentViewSnapshotTest: XCTestCase {
    var sut: ContentView?
    var viewModel: ContentViewModel?
    var contentRepository: MockContentRepository?

    override func setUp() async throws {
        contentRepository = MockContentRepository()
        viewModel = .init(contentRepository: contentRepository!)
        sut = .init(viewModel: viewModel!, slug: "SLUG", ownerUsername: "OWNER_USERNAME")
    }

    override func tearDown() async throws {
        sut = nil
        viewModel = nil
        contentRepository = nil
    }

    func testContentState() async throws {
        stub(contentRepository!) { stub in
            when(stub.getPost(ownerUsername: any(), slug: any())).thenReturn(ContentDTO.fixture())
        }
        await viewModel?.getContent(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut!, name: "content_view")
    }

    func testErrorState() async throws {
        stub(contentRepository!) { stub in
            when(stub.getPost(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }
        await viewModel?.getContent(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut!, name: "content_view_error")
    }

    func testLoadingState() async throws {
        stub(contentRepository!) { stub in
            when(stub.getPost(ownerUsername: any(), slug: any())).thenReturn(ContentDTO.fixture())
        }
        Snapshooter.snapshot(sut!, name: "content_view_loading")
    }
}
