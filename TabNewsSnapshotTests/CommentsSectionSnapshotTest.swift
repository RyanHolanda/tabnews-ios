import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor
// Need to test comments sorting
final class CommentsSectionSnapshotTest: XCTestCase {
    var sut: CommentsSection?
    var viewModel: CommentsSectionViewModel?
    var repository: MockContentRepository?

    override func setUp() async throws {
        repository = MockContentRepository()
        viewModel = CommentsSectionViewModel(repository: repository!)
        sut = .init(viewModel: viewModel!, todayDate: Date(year: 2017, month: 11, day: 11), ownerUsername: "username", slug: "slug")
    }

    override func tearDown() async throws {
        viewModel = nil
        repository = nil
        repository = nil
    }

    func testContentState() async throws {
        stub(repository!) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenReturn([
                CommentDTO.fixture(),
                CommentDTO.fixture()
            ])
        }
        await viewModel?.getComments(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut, name: "comments_section")
    }

    func testErrorState() async throws {
        stub(repository!) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }
        await viewModel?.getComments(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut, name: "comments_section_error")
    }

    func testLoadingState() async throws {
        stub(repository!) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }

        Snapshooter.snapshot(sut, name: "comments_section_loading")
    }

    func testContentStateWithSkrankCommentText() async throws {
        stub(repository!) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenReturn([
                CommentDTO.fixture().copyWith(body: """
                Just a LONG comment to see the comment card shrank. Just a LONG comment to see the comment card shrank.
                Just a LONG comment to see the comment card shrank.
                Just a LONG comment to see the comment card shrank.
                Just a LONG comment to see the comment card shrank. Just a LONG comment to see the comment card shrank
                Just a LONG comment to see the comment card shrank. Just a LONG comment to see the comment card shrank.
                Just a LONG comment to see the comment card shrank.
                Just a LONG comment to see the comment card shrank.
                Just a LONG comment to see the comment card shrank. Just a LONG comment to see the comment card shrank
                """)
            ])
        }
        await viewModel?.getComments(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut, name: "comments_section_text_shrank")
    }
}
