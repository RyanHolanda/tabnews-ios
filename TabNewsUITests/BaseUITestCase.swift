import XCTest

class BaseUITestCase: XCTestCase, UITestElements {
    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }
}
