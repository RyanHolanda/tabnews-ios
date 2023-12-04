import XCTest

final class ContentViewUITests: BaseUITestCase {
    func testGoingBackgroundAndComingBack() {
        RecentsViewRobot()
            .openPost()
            .putAppInBackground()
            .putAppInForeground()

        XCTAssertTrue(staticText("content-title").exists, "Content not found when coming back from background")
    }
}
