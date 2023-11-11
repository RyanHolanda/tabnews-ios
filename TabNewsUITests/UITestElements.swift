import Foundation
import XCTest

private var currentApp: XCUIApplication?

protocol UITestElements {
    var app: XCUIApplication { get }
}

extension UITestElements {
    var app: XCUIApplication {
        if let app = currentApp {
            return app
        } else {
            currentApp = XCUIApplication()
            return currentApp!
        }
    }

    func button() -> XCUIElement { app.buttons.element }
    func button(_ identifier: String) -> XCUIElement { app.buttons[identifier] }
}
