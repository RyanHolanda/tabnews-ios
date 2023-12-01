import Cuckoo
import SwiftUI
@testable import TabNews
import ViewInspector
import XCTest

@MainActor
final class CommentRepliesViewUnitTests: XCTestCase {
    var sut: (any View)?
    var viewModel: CommentRepliesViewModel?
    let contentRepository: MockContentRepository = .init()

    override func setUp() async throws {
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }

        InjectionService.shared.registerFactory {
            self.contentRepository as ContentRepository
        }

        stub(contentRepository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenReturn([CommentDTO.fixture(), CommentDTO.fixture(), CommentDTO.fixture()])
        }

        viewModel = .init(repository: contentRepository)
        sut = AnyView(NavigationStack {
            CommentRepliesView(commentOwnerUsername: "Marge", commentSlug: "", viewModel: viewModel!)
        }.environmentObject(CommentsSectionViewModel(repository: contentRepository))
        )
    }

    override func tearDown() async throws {
        sut = nil
        InjectionService.shared.reset()
    }

    func testErrorStateTryAgain() async throws {
        stub(contentRepository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }

        await viewModel!.getReplies(commentOwnerUsername: "", commentSlug: "")

        let tryAgainButton: InspectableView = try sut!.inspect().find(button: String(localized: .localizable.tryAgain))
        try tryAgainButton.tap()

        try await Task.sleep(nanoseconds: 1000000)

        verify(contentRepository, times(2)).getComments(ownerUsername: any(), slug: any())
    }
}
