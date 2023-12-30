import XCTest

class BaseUITestCase: XCTestCase, UITestElements {
    override func setUpWithError() throws {
        app.launchEnvironment["env"] = "local"
        app.launch()
        continueAfterFailure = false
    }
}
