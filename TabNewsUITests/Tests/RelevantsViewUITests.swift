import XCTest

final class RelevantsViewUITests: BaseUITestCase {
    let mainViewRobot: MainViewRobot = .init()

    func testOpenPost() {
        mainViewRobot
            .goToRelevantsTab()
            .relevantsViewRobot
            .openPost(index: 0)

        XCTAssertTrue(staticText("content-title").exists, "The post could not be found")
    }
}
