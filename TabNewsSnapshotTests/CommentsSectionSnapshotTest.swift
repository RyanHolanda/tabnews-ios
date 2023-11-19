import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor final class CommentsSectionSnapshotTest: XCTestCase {
    var sut: CommentsSection?
    var viewModel: CommentsSectionViewModel?
    var repository: MockContentRepository = .init()

    override func setUp() async throws {
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }

        InjectionService.shared.registerFactory {
            self.repository as ContentRepository
        }

        viewModel = CommentsSectionViewModel(repository: repository)
        sut = .init(viewModel: viewModel!, ownerUsername: "username", slug: "slug")
    }

    override func tearDown() async throws {
        viewModel = nil
        sut = nil
        InjectionService.shared.reset()
    }

    func testContentState() async throws {
        stub(repository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenReturn([
                CommentDTO.fixture()
            ])
        }

        await viewModel?.getComments(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut, name: "comments_section")
    }

    func testErrorState() async throws {
        stub(repository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }
        await viewModel?.getComments(ownerUsername: "", slug: "")
        Snapshooter.snapshot(sut, name: "comments_section_error")
    }

    func testLoadingState() async throws {
        stub(repository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }

        Snapshooter.snapshot(sut, name: "comments_section_loading")
    }

    func testContentStateWithSkrankCommentText() async throws {
        stub(repository) { stub in
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

    func testContentStateWithSortedCommentsByRecent() async throws {
        stub(repository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenReturn([
                CommentDTO.fixture().copyWith(id: "LATER", body: "Later Comment", publishedAt: "2010-11-24T22:21:17.146Z"),
                CommentDTO.fixture().copyWith(id: "EARLIER", body: "Earlier Comment", publishedAt: "2010-11-25T22:21:17.146Z")
            ])
        }

        await viewModel?.getComments(ownerUsername: "", slug: "")
        let sortByButton: InspectableView = try sut!.inspect().find(button: CommentsSectionListOrder.recents.label)
        try sortByButton.tap()
        Snapshooter.snapshot(sut, name: "comments_section_sorted_by_recent")
        XCTAssertEqual(viewModel?.comments.first?.id, "EARLIER")
    }

    func testContentStateWithSortedCommentsByRelevantsFromSortedByRecent() async throws {
        stub(repository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenReturn([
                CommentDTO.fixture().copyWith(body: "Less Relevant Comment", tabcoins: 50),
                CommentDTO.fixture().copyWith(body: "Unrelevant Comment", tabcoins: 0),
                CommentDTO.fixture().copyWith(id: "RELEVANT", body: "Relevant Comment", tabcoins: 200)
            ])
        }

        await viewModel?.getComments(ownerUsername: "", slug: "")
        let sortRecentsByButton: InspectableView = try sut!.inspect().find(button: CommentsSectionListOrder.recents.label)
        try sortRecentsByButton.tap()
        let sortByRelevantsButton: InspectableView = try sut!.inspect().find(button: CommentsSectionListOrder.relevants.label)
        try sortByRelevantsButton.tap()
        Snapshooter.snapshot(sut, name: "comments_section_sorted_by_relevants")
        XCTAssertEqual(viewModel?.comments.first?.id, "RELEVANT")
    }
}
