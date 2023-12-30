import XCTest

class BaseUITestCase: XCTestCase, UITestElements {
    override func setUpWithError() throws {
        if !LocalServer.shared.server.operating { LocalServer.shared.run() }

        app.launchEnvironment["env"] = "local"
        app.launch()
        continueAfterFailure = false
    }
}
