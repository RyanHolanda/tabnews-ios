import Cuckoo
@testable import TabNews
import XCTest

@MainActor
final class CommentRepliesViewSnapshotTest: XCTestCase {
    var sut: CommentRepliesView?
    var viewModel: CommentRepliesViewModel?
    let contentRepository: MockContentRepository = .init()

    override func setUp() async throws {
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }

        stub(contentRepository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenReturn([CommentDTO.fixture(), CommentDTO.fixture(), CommentDTO.fixture()])
        }

        viewModel = .init(repository: contentRepository)
        sut = .init(commentOwnerUsername: "Marge", commentSlug: "", viewModel: viewModel!)
    }

    override func tearDown() async throws {
        sut = nil
        InjectionService.shared.reset()
    }

    func testContentState() async throws {
        await viewModel!.getReplies(commentOwnerUsername: "", commentSlug: "")

        Snapshooter.snapshot(sut, name: "comment_replies")
    }

    func testLoadingState() async throws {
        Snapshooter.snapshot(sut, name: "comment_replies_loading")
    }

    func testErrorState() async throws {
        stub(contentRepository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }

        await viewModel!.getReplies(commentOwnerUsername: "", commentSlug: "")

        Snapshooter.snapshot(sut, name: "comment_replies_error")
    }
}
