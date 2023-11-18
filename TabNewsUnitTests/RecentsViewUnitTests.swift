import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor
class RecentsViewUnitTests: XCTestCase {
    var contentRepository: MockContentRepository = .init()
    var viewModel: RecentsViewModel?
    var sut: RecentsView?

    func testRecentsViewErrorfetch() async throws {
        stub(contentRepository) { stub in
            when(stub.getRecentsPosts(page: any(), perPage: any()))
                .thenThrow(HTTP.HTTPError.invalidUrl)
        }

        viewModel = .init(repository: contentRepository)
        sut = .init(viewModel: viewModel!, todayDate: Date(year: 2017, month: 11, day: 11))

        while viewModel?.state != .error {
            try await Task.sleep(nanoseconds: 1)
        }

        let tryAgainButton: InspectableView = try sut!.inspect().find(button: String(localized: .localizable.tryAgain))
        try tryAgainButton.tap()

        try await Task.sleep(nanoseconds: 100000)

        verify(contentRepository, times(2)).getRecentsPosts(page: any(), perPage: any()).with(returnType: [ContentPreviewDTO].self)
    }
}
