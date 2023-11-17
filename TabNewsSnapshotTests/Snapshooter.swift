import Foundation
import SnapshotTesting
import SwiftUI

var updateSnapshots: Bool = false

enum Snapshooter {
    static func snapshot(_ view: some View, name: String) {
        let snapshotView: UIHostingController = .init(rootView: view)
        assertSnapshot(
            matching: snapshotView,
            as: .image(on: .iPhoneX, perceptualPrecision: 0.9, traits: .init(userInterfaceStyle: .dark)),
            record: updateSnapshots,
            testName: "\(name)_dark_mode"
        )

        assertSnapshot(
            matching: snapshotView,
            as: .image(on: .iPhoneX, perceptualPrecision: 0.9, traits: .init(userInterfaceStyle: .light)),
            record: updateSnapshots,
            testName: "\(name)_light_mode"
        )
    }
}
