import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor
final class ContentViewUnitTests: XCTestCase {
    var sut: ContentView?
    var viewModel: ContentViewModel?
    var contentRepository: MockContentRepository?
    let postSlug: String = "SLUG"
    let postOwnerUsername: String = "OWNER_USERNAME"

    override func setUp() async throws {
        contentRepository = MockContentRepository()
        viewModel = .init(contentRepository: contentRepository!)
        sut = .init(viewModel: viewModel!, slug: postSlug, ownerUsername: postOwnerUsername)
    }

    override func tearDown() async throws {
        sut = nil
        viewModel = nil
        contentRepository = nil
    }

    func testErrorStateRetry() async throws {
        stub(contentRepository!) { stub in
            when(stub.getPost(ownerUsername: any(), slug: any())).thenThrow(HTTP.HTTPError.responseError)
        }
        await viewModel?.getContent(ownerUsername: postOwnerUsername, slug: postSlug)

        let tryAgainButton: InspectableView = try sut!.inspect().find(button: String(localized: .localizable.tryAgain))
        try tryAgainButton.tap()

        try await Task.sleep(nanoseconds: 100_000)

        verify(contentRepository!, times(2)).getPost(ownerUsername: postOwnerUsername, slug: postSlug)
    }
}
