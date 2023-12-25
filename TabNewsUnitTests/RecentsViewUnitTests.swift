import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor class RecentsViewUnitTests: XCTestCase {
    var contentRepository: MockContentRepository = .init()
    var viewModel: RecentsViewModel?
    var sut: RecentsView?

    override func setUp() async throws {
        continueAfterFailure = false
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }

        InjectionService.shared.registerFactory {
            self.contentRepository as ContentRepository
        }
    }

    override func tearDown() async throws {
        InjectionService.shared.reset()
    }

    func testRecentsViewErrorfetch() async throws {
        stub(contentRepository) { stub in
            when(stub.getRecentsPosts(page: any(), perPage: any()))
                .thenThrow(HTTP.HTTPError.invalidUrl)
        }

        viewModel = .init(repository: contentRepository)
        sut = .init(viewModel: viewModel!)

        while viewModel?.state != .error {
            try await Task.sleep(nanoseconds: 1)
        }

        let tryAgainButton: InspectableView = try sut!.inspect().find(button: String(localized: .localizable.tryAgain))
        try tryAgainButton.tap()

        try await Task.sleep(nanoseconds: 1000000000)

        verify(contentRepository, times(5)).getRecentsPosts(page: any(), perPage: any()).with(returnType: [ContentPreviewDTO].self)
    }
}
