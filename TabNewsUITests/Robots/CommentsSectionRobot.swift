import Foundation

class CommentsSectionRobot: AppRobot {
    @discardableResult
    func sortCommentsByRelevants() -> CommentsSectionRobot {
        button("comments-sort").tap()
        button("sort-relevants").tap()

        return CommentsSectionRobot()
    }

    @discardableResult
    func sortCommentsByRecents() -> CommentsSectionRobot {
        button("comments-sort").tap()
        button("sort-recents").tap()

        return CommentsSectionRobot()
    }

    @discardableResult
    func openCommentReplies() -> CommentsSectionRobot {
        while !button("comment-replies").firstMatch.exists {
            app.swipeUp()
        }

        button("comment-replies").firstMatch.tap()

        return CommentsSectionRobot()
    }

    @discardableResult
    func closeCommentReplies() -> CommentsSectionRobot {
        button("dismiss-comment-replies").tap()

        return CommentsSectionRobot()
    }
}
