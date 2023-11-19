import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor
final class CommentsSectionUnitTests: XCTestCase {
    var sut: CommentsSection?
    var viewModel: CommentsSectionViewModel?
    let repository: MockContentRepository = .init()

    override func setUpWithError() throws {
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }

        InjectionService.shared.registerFactory {
            self.repository as ContentRepository
        }

        viewModel = CommentsSectionViewModel(repository: repository)
        sut = CommentsSection(viewModel: viewModel!, ownerUsername: "", slug: "")
    }

    override func tearDownWithError() throws {
        InjectionService.shared.reset()
    }

    func testTryAgainOnErrorState() async throws {
        stub(repository) { stub in
            when(stub.getComments(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }

        await viewModel?.getComments(ownerUsername: "", slug: "")

        let tryAgainButton: InspectableView = try sut!.inspect().find(button: String(localized: .localizable.tryAgain))
        try tryAgainButton.tap()

        try await Task.sleep(nanoseconds: 15000000)

        verify(repository, times(2)).getComments(ownerUsername: "", slug: "")
    }
}
