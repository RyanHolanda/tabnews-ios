import Foundation
import SnapshotTesting
import SwiftUI

class Snapshooter {
    static func snapshot(_ view: some View, name: String, isRecording: Bool = false) {
        let snapshotView: UIHostingController = .init(rootView: view)
        assertSnapshot(
            matching: snapshotView,
            as: .image(on: .iPhoneX, traits: .init(userInterfaceStyle: .dark)),
            record: isRecording,
            testName: "\(name)_dark_mode"
        )

        assertSnapshot(
            matching: snapshotView,
            as: .image(on: .iPhoneX, traits: .init(userInterfaceStyle: .light)),
            record: isRecording,
            testName: "\(name)_light_mode"
        )
    }
}
