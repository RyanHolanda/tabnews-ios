import Foundation

class CommentsSectionRobot: AppRobot {
    func sortCommentsByRelevants() {}

    func sortCommentsByRecents() {
        button("comments-sort").tap()
        button("sort-recents").tap()
    }
}
