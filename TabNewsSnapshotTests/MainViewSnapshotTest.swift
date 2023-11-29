import Cuckoo
@testable import TabNews
import ViewInspector
import XCTest

final class MainViewSnapshotTest: XCTestCase {
    var sut: MainView?
    let contentRepository: MockContentRepository = .init()

    override func setUp() async throws {
        InjectionService.shared.registerFactory { self.contentRepository as ContentRepository }

        stub(contentRepository) { stub in
            when(stub.getRecentsPosts(page: any(), perPage: any())).thenReturn([])
            when(stub.getRelevantsPosts(page: any(), perPage: any())).thenReturn([])
        }

        sut = .init()
    }

    override func tearDown() async throws {
        sut = nil
    }

    func testMainView() {
        Snapshooter.snapshot(sut, name: "main_view")
    }
}
