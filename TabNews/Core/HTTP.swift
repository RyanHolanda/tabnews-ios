import Foundation

protocol HTTPProtocol {
    func get<T: Decodable>(_ url: String) async throws -> T
}

class HTTP: HTTPProtocol {
    private let session: URLSession
    private let baseURL: String

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    enum HTTPError: Error {
        case invalidUrl
        case responseError
    }

    func get<T: Decodable>(_ url: String) async throws -> T {
        guard let url = URL(string: baseURL + url) else {
            throw HTTPError.invalidUrl
        }
        let request: URLRequest = .init(url: url, timeoutInterval: 120.0)
        Logger.logRequest(request: request)

        let (data, response): (Data, URLResponse) = try await session.data(for: request)

        guard let responseStatusCode = response as? HTTPURLResponse, (200 ..< 300) ~= responseStatusCode.statusCode else {
            throw HTTPError.responseError
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
