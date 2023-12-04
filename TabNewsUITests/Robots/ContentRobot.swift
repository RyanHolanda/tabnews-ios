import Foundation

class ContentRobot: AppRobot {
    @discardableResult
    func scrollDown() -> ContentRobot {
        app.swipeUp()
        return ContentRobot()
    }

    func commentsSectionRobot() -> CommentsSectionRobot {
        CommentsSectionRobot()
    }
}
