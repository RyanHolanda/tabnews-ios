import XCTest

final class RecentsViewUITests: BaseUITestCase {
    let mainViewRobot: MainViewRobot = .init()

    func testOpenPost() {
        mainViewRobot
            .goToRecentsTab()
            .recentsViewRobot
            .openPost(index: 0)

        XCTAssertTrue(staticText("content-title").exists, "The post could not be found")
    }
}
