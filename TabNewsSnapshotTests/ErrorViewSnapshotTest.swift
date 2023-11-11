import SnapshotTesting
import SwiftUI
@testable import TabNews
import XCTest

final class ErrorViewSnapshotTest: XCTestCase {
    func testErrorViewSnapshot() throws {
        let view: ErrorView = .init(title: "Error", description: "Please try again", onTryAgain: {})

        Snapshooter.snapshot(view, name: "error_view")
    }
}
