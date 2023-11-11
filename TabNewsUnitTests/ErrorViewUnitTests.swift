@testable import TabNews
import ViewInspector
import XCTest

final class ErrorViewUnitTest: XCTestCase {
    func testErrorViewCallback() throws {
        var counter: Int = 1

        let view: ErrorView = .init(title: "Error", description: "Please try again") {
            counter += 1
        }
        let tryAgainButton: InspectableView = try view.inspect().find(button: String(localized: .localizable.tryAgain))
        try tryAgainButton.tap()

        XCTAssert(counter == 2)
    }
}
