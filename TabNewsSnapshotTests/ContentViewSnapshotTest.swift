import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor class ContentViewSnapshotTest: XCTestCase {
    var sut: ContentView?
    var viewModel: ContentViewModel?
    var contentRepository: MockContentRepository = .init()

    override func setUp() async throws {
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }

        InjectionService.shared.registerFactory {
            self.contentRepository as ContentRepository
        }

        viewModel = .init(contentRepository: contentRepository)
        sut = .init(viewModel: viewModel!, slug: "SLUG", ownerUsername: "OWNER_USERNAME")

        stub(contentRepository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenReturn([CommentDTO.fixture()])
        }
    }

    override func tearDown() async throws {
        sut = nil
        viewModel = nil
        InjectionService.shared.reset()
    }

    func testContentState() async throws {
        stub(contentRepository) { stub in
            when(stub.getPost(ownerUsername: any(), slug: any())).thenReturn(ContentDTO.fixture())
        }
        await viewModel?.getContent(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut!, name: "content_view")
    }

    func testErrorState() async throws {
        stub(contentRepository) { stub in
            when(stub.getPost(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }
        await viewModel?.getContent(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut!, name: "content_view_error")
    }

    func testLoadingState() async throws {
        stub(contentRepository) { stub in
            when(stub.getPost(ownerUsername: any(), slug: any())).thenReturn(ContentDTO.fixture())
        }
        Snapshooter.snapshot(sut!, name: "content_view_loading")
    }
}
