import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

@MainActor class RecentsViewSnapshotTest: XCTestCase {
    var contentRepository: MockContentRepository = .init()
    var viewModel: RecentsViewModel?
    var sut: RecentsView?

    override func setUp() async throws {
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }

        InjectionService.shared.registerFactory {
            self.contentRepository as ContentRepository
        }

        stub(contentRepository) { stub in
            when(stub.getRecentsPosts(page: any(), perPage: any())).thenReturn([
                ContentPreviewDTO.fixture(),
                ContentPreviewDTO(
                    id: ContentPreviewDTO.fixture().id,
                    ownerId: ContentPreviewDTO.fixture().ownerId,
                    parentId: ContentPreviewDTO.fixture().parentId,
                    slug: ContentPreviewDTO.fixture().slug,
                    title: ContentPreviewDTO.fixture().title,
                    publishedAt: ContentPreviewDTO.fixture().publishedAt,
                    ownerUsername: ContentPreviewDTO.fixture().ownerUsername,
                    tabcoins: ContentPreviewDTO.fixture().tabcoins,
                    comentsCount: 2
                ),
                ContentPreviewDTO(
                    id: ContentPreviewDTO.fixture().id,
                    ownerId: ContentPreviewDTO.fixture().ownerId,
                    parentId: ContentPreviewDTO.fixture().parentId,
                    slug: ContentPreviewDTO.fixture().slug,
                    title: ContentPreviewDTO.fixture().title,
                    publishedAt: ContentPreviewDTO.fixture().publishedAt,
                    ownerUsername: ContentPreviewDTO.fixture().ownerUsername,
                    tabcoins: ContentPreviewDTO.fixture().tabcoins,
                    comentsCount: 1
                )
            ])
        }

        viewModel = .init(repository: contentRepository)
        sut = .init(viewModel: viewModel!)
    }

    override func tearDown() async throws {
        InjectionService.shared.reset()
    }

    func testRecentsViewContent() async throws {
        while viewModel?.state != .success {
            try await Task.sleep(nanoseconds: 1)
        }

        Snapshooter.snapshot(sut, name: "recents_view")
    }

    func testRecentsViewError() async throws {
        let contentRepository: MockContentRepository = .init()
        stub(contentRepository) { stub in
            when(stub.getRecentsPosts(page: any(), perPage: any()))
                .thenThrow(HTTP.HTTPError.invalidUrl)
        }

        let viewModel: RecentsViewModel = .init(repository: contentRepository)
        let sut: RecentsView = .init(viewModel: viewModel)

        while viewModel.state != .error {
            try await Task.sleep(nanoseconds: 1)
        }

        Snapshooter.snapshot(sut, name: "recents_view_error")
    }

    func testRecentsViewLoading() async throws {
        stub(contentRepository) { stub in
            when(stub.getRecentsPosts(page: any(), perPage: any()))
                .thenThrow(HTTP.HTTPError.invalidUrl)
        }

        viewModel = .init(repository: contentRepository)
        sut = .init(viewModel: viewModel!)

        while viewModel?.state != .loading {
            try await Task.sleep(nanoseconds: 1)
        }

        Snapshooter.snapshot(sut, name: "recents_view_loading")
    }
}
