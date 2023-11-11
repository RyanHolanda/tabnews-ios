import Foundation
#if DEBUG
    enum Logger {
        static func logError(error: Error) {
            debugPrint("[E] An error occured >>> \(error)")
        }

        static func logRequest(request: URLRequest) {
            print("\n<<<<<<<<<<[HTTP Request]>>>>>>>>>>")
            print("URL: \(request.url?.absoluteString ?? "")")
            print("Method: \(request.httpMethod ?? "Unknown Method")")
        }
    }
#endif
