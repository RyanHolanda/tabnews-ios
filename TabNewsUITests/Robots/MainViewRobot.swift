import Foundation

class MainViewRobot: AppRobot {
    @discardableResult
    func goToRelevantsTab() -> (relevantsViewRobot: RelevantsViewRobot, mainViewRobot: MainViewRobot) {
        button("Relevantes").tap()

        return (RelevantsViewRobot(), MainViewRobot())
    }

    @discardableResult
    func goToRecentsTab() -> (recentsViewRobot: RecentsViewRobot, mainViewRobot: MainViewRobot) {
        button("Recentes").tap()

        return (RecentsViewRobot(), MainViewRobot())
    }
}
