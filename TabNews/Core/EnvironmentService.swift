import Foundation

class EnvironmentService {
    static func getAPIBaseUrl() -> String {
        if ProcessInfo.processInfo.environment["env"] == "local" {
            "http://localhost:8080"
        } else {
            .APIbaseUrl
        }
    }
}
