import Foundation

class ContentRobot: AppRobot {
    @discardableResult
    func back() -> PostsListRobot {
        app.navigationBars.buttons.element(boundBy: 0).tap()
        return PostsListRobot()
    }

    @discardableResult
    func scrollCodeBlock() -> ContentRobot {
        while !scrollView("code-block-scroll-view").firstMatch.isHittable {
            scrollDown()
        }

        scrollView("code-block-scroll-view").firstMatch.swipeLeft()
        return ContentRobot()
    }

    @discardableResult
    func copyContentLink() -> ContentRobot {
        button("share-post").tap()
        cells("Copiar").tap()

        return ContentRobot()
    }

    @discardableResult
    func share() -> ContentRobot {
        button("share-post").tap()
        return ContentRobot()
    }

    @discardableResult
    func scrollDown() -> ContentRobot {
        app.swipeUp()
        return ContentRobot()
    }

    func commentsSectionRobot() -> CommentsSectionRobot {
        CommentsSectionRobot()
    }
}
