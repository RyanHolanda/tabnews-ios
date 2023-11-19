import SwiftUI

@main class Launcher {
    static func main() {
        guard NSClassFromString("XCTestCase") == nil else {
            return TestApp.main()
        }
        return TabNewsApp.main()
    }
}

struct TabNewsApp: App {
    init() { setupInjections() }

    var body: some Scene {
        WindowGroup {
            NavigationView()
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Test App")
        }
    }
}
