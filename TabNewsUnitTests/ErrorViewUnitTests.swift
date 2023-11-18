@testable import TabNews
import ViewInspector
import XCTest

final class ErrorViewUnitTest: XCTestCase {
    func testErrorViewCallback() async throws {
        var counter: Int = 1

        let view: ErrorView = .init(title: "Error", description: "Please try again") {
            counter = 2
        }

        let tryAgainButton: InspectableView = try view.inspect().find(button: String(localized: .localizable.tryAgain))
        try tryAgainButton.tap()

        try? await Task.sleep(nanoseconds: 100000000)

        XCTAssertEqual(counter, 2)
    }
}
