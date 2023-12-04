import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor class RelevantsViewUnitTests: XCTestCase {
    var contentRepository: MockContentRepository = .init()
    var viewModel: RelevantsViewModel?
    var sut: RelevantsView?

    override func setUp() async throws {
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

    func testRelevantsViewViewErrorfetch() async throws {
        stub(contentRepository) { stub in
            when(stub.getRelevantsPosts(page: any(), perPage: any()))
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

        verify(contentRepository, times(2)).getRelevantsPosts(page: any(), perPage: any()).with(returnType: [ContentPreviewDTO].self)
    }
}
