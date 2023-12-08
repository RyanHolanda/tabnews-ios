import XCTest

class BaseUITestCase: XCTestCase, UITestElements {
    var localServer: LocalServer?

    override func setUpWithError() throws {
        localServer = .init()
        localServer!.run()
        app.launchEnvironment["env"] = "local"
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        localServer!.stop()
        localServer = nil
    }
}
