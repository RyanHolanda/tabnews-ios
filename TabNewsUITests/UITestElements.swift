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

    func textView() -> XCUIElement { app.textViews.element }
    func textView(_ identifier: String) -> XCUIElement { app.textViews[identifier] }

    func staticText() -> XCUIElement { app.staticTexts.element }
    func staticText(_ identifier: String) -> XCUIElement { app.staticTexts[identifier] }

    func menu() -> XCUIElement { app.menus.element }
    func menu(_ identifier: String) -> XCUIElement { app.menus[identifier] }
}
