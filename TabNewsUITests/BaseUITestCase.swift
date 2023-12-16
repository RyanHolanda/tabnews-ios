import XCTest

class BaseUITestCase: XCTestCase, UITestElements {
    override func setUpWithError() throws {
        app.launchEnvironment["env"] = "local"
        LocalServer.shared.run()

        app.launch()
        continueAfterFailure = false
    }

    override func tearDown() async throws {
        LocalServer.shared.stop()
    }
}
