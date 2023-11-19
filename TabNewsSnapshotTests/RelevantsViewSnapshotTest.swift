import Cuckoo
@testable import TabNews
import XCTest

@MainActor class RelevantsViewSnapshotTest: XCTestCase {
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

        stub(contentRepository) { stub in
            when(stub.getRelevantsPosts(page: any(), perPage: any())).thenReturn([
                ContentPreviewDTO.fixture(),
                ContentPreviewDTO.fixture()
            ])
        }

        viewModel = .init(repository: contentRepository)
        sut = .init(viewModel: viewModel!)
    }

    override func tearDown() async throws {
        InjectionService.shared.reset()
    }

    func testContentView() async throws {
        while viewModel?.state != .success {
            try await Task.sleep(nanoseconds: 1)
        }

        Snapshooter.snapshot(sut, name: "relevants_view")
    }

    func testErrorView() async throws {
        let contentRepository: MockContentRepository = .init()
        stub(contentRepository) { stub in
            when(stub.getRelevantsPosts(page: any(), perPage: any()))
                .thenThrow(HTTP.HTTPError.invalidUrl)
        }

        let viewModel: RelevantsViewModel = .init(repository: contentRepository)
        let sut: RelevantsView = .init(viewModel: viewModel)

        while viewModel.state != .error {
            try await Task.sleep(nanoseconds: 1)
        }

        Snapshooter.snapshot(sut, name: "relevants_view_error")
    }

    func testLoadingView() async throws {
        stub(contentRepository) { stub in
            when(stub.getRelevantsPosts(page: any(), perPage: any()))
                .thenThrow(HTTP.HTTPError.invalidUrl)
        }

        viewModel = .init(repository: contentRepository)
        sut = .init(viewModel: viewModel!)

        while viewModel?.state != .loading {
            try await Task.sleep(nanoseconds: 1)
        }

        Snapshooter.snapshot(sut, name: "relevants_view_loading")
    }
}
