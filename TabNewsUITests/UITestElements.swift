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
            LocalServer.shared.run()
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

    func scrollView() -> XCUIElement { app.scrollViews.element }
    func scrollView(_ identifier: String) -> XCUIElement { app.scrollViews[identifier] }

    func collectionView() -> XCUIElement { app.collectionViews.element }
    func collectionView(_ identifier: String) -> XCUIElement { app.collectionViews[identifier] }

    func cells() -> XCUIElement { app.cells.element }
    func cells(_ identifier: String) -> XCUIElement { app.cells[identifier] }
}
