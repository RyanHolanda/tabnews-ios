import Foundation
enum Logger {
    static func logError(error: Error) {
        #if DEBUG
            print("[E] An error occured >>> \(error)")
        #endif
    }

    static func logRequest(request: URLRequest) {
        #if DEBUG
            print("\n<<<<<<<<<<[HTTP Request]>>>>>>>>>>")
            print("URL: \(request.url?.absoluteString ?? "")")
            print("Method: \(request.httpMethod ?? "Unknown Method")")
        #endif
    }
}
