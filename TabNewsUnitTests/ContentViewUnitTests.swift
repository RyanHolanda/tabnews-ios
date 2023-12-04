import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor final class ContentViewUnitTests: XCTestCase {
    var sut: ContentView?
    var viewModel: ContentViewModel?
    let contentRepository: MockContentRepository = .init()
    let postSlug: String = "SLUG"
    let postOwnerUsername: String = "OWNER_USERNAME"

    override func setUp() async throws {
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }

        InjectionService.shared.registerFactory {
            self.contentRepository as ContentRepository
        }
        viewModel = .init(contentRepository: contentRepository)
        sut = .init(viewModel: viewModel!, slug: postSlug, ownerUsername: postOwnerUsername)
    }

    override func tearDown() async throws {
        sut = nil
        viewModel = nil
        InjectionService.shared.reset()
    }

    func testErrorStateRetry() async throws {
        stub(contentRepository) { stub in
            when(stub.getPost(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }
        await viewModel?.getContent(ownerUsername: postOwnerUsername, slug: postSlug)

        let tryAgainButton: InspectableView = try sut!.inspect().find(button: String(localized: .localizable.tryAgain))
        try tryAgainButton.tap()

        try await Task.sleep(nanoseconds: 1000000000)

        verify(contentRepository, times(2)).getPost(ownerUsername: postOwnerUsername, slug: postSlug)
    }
}
