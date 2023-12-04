import Foundation

class PostsListRobot: AppRobot {
    @discardableResult
    func openPost(index: Int) -> ContentRobot {
        button("post-\(index)").tap()
        return ContentRobot()
    }

    @discardableResult
    func scrollDown() -> PostsListRobot {
        app.swipeUp()
        return PostsListRobot()
    }

    @discardableResult
    func scrollUp() -> PostsListRobot {
        app.swipeDown()
        return PostsListRobot()
    }
}
