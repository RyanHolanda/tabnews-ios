import XCTest

final class ContentViewUITests: BaseUITestCase {
    func testGoingBackgroundAndComingBack() {
        RecentsViewRobot()
            .openPost()
            .putAppInBackground()
            .putAppInForeground()

        XCTAssertTrue(staticText("content-title").exists, "Content not found when coming back from background")
    }

    func testBack() {
        RecentsViewRobot()
            .openPost()
            .back()

        XCTAssertTrue(!staticText("content-title").exists, "Content view is still showing after tapping back")
    }

    func testSharePostAction() {
        RecentsViewRobot()
            .openPost()
            .share()

        let textInsideShareSheetExists: Bool = staticText("Copiar").waitForExistence(timeout: 5)

        XCTAssertTrue(textInsideShareSheetExists, "Share sheet not found")
    }

    func testCopyPostLink() {
        RecentsViewRobot()
            .openPost()
            .copyContentLink()
    }

    func testOpenCommentReplies() {
        RecentsViewRobot()
            .openPost()
            .commentsSectionRobot()
            .openCommentReplies()

        XCTAssertTrue(scrollView("comment-replies-scroll").exists, "Comment replies sheet not found")
    }

    func testCloseCommentRepliesSheet() {
        RecentsViewRobot()
            .openPost()
            .commentsSectionRobot()
            .openCommentReplies()
            .closeCommentReplies()

        XCTAssertTrue(!scrollView("comment-replies-scroll").exists, "Comment replies sheet has not closed")
    }

    func testCloseCommentRepliesSheetAfterNavigatingThroughCommentReplies() {
        RecentsViewRobot()
            .openPost()
            .commentsSectionRobot()
            .openCommentReplies()
            .openCommentReplies()
            .openCommentReplies()
            .closeCommentReplies()

        XCTAssertTrue(!scrollView("comment-replies-scroll").exists, "Comment replies sheet has not closed")
    }
}
