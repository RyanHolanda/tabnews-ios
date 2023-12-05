import LocalServer
import XCTest

class BaseUITestCase: XCTestCase, UITestElements {
    override func setUpWithError() throws {
        XCUIApplication(bundleIdentifier: "com.holland.LocalServer").launch()
        app.launchEnvironment["env"] = "local"
        app.launch()
        continueAfterFailure = false
    }
}
