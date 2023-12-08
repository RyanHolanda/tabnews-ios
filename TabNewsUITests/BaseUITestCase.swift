import XCTest

class BaseUITestCase: XCTestCase, UITestElements {
    let localServer: LocalServer = .init()

    override func setUpWithError() throws {
        localServer.run()
        app.launchEnvironment["env"] = "local"
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        localServer.stop()
    }
}
