import Foundation
import XCTest

class AppRobot: UITestElements {
    @discardableResult
    func putAppInBackground() -> AppRobot {
        XCUIDevice.shared.press(.home)
        return AppRobot()
    }

    @discardableResult
    func putAppInForeground() -> AppRobot {
        app.activate()
        return AppRobot()
    }
}
