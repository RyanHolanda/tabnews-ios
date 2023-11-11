import XCTest

class BaseTestCase: XCTestCase, UITestElements {
    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }
}
