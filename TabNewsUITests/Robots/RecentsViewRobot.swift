import Foundation

class RecentsViewRobot: AppRobot {
    let postsListRobot: PostsListRobot = .init()

    @discardableResult
    func openPost(index: Int = 0) -> ContentRobot {
        postsListRobot.openPost(index: index)
    }

    @discardableResult
    func scrollDown() -> PostsListRobot {
        postsListRobot.scrollDown()
    }

    @discardableResult
    func scrollUp() -> PostsListRobot {
        postsListRobot.scrollUp()
    }
}
