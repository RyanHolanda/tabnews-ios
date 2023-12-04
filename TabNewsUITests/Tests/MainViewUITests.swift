final class MainViewUITests: BaseUITestCase {
    private let mainViewRobot: MainViewRobot = .init()

    func testGoToRelevantsView() {
        mainViewRobot
            .goToRelevantsTab()
    }

    func testGoToRelevantsThenRecentsTab() {
        mainViewRobot
            .goToRelevantsTab()
            .mainViewRobot
            .goToRecentsTab()
    }
}
