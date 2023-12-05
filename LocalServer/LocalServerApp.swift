import SwiftUI

@main
struct LocalServerApp: App {
    let localServer: LocalServer = .init()
    var localServerUrl: String?

    init() {
        localServer.run()
        if let localServerPort = localServer.getPort() {
            self.localServerUrl = "http://localhost:\(String(localServerPort))"
        }
    }

    var body: some Scene {
        WindowGroup {
            if localServerUrl != nil {
                Text("Local Server Running at:")
                Text(localServerUrl!)
                    .bold()
                    .foregroundStyle(.yellow)
                    .contextMenu(ContextMenu(menuItems: {
                        Button("Copy port") {
                            UIPasteboard.general.string = String(localServer.getPort()!)
                        }
                        Button("Copy URL") {
                            UIPasteboard.general.string = localServerUrl
                        }
                    }))
            } else {
                Text("Failed to define a local server URL")
            }
        }
    }
}
