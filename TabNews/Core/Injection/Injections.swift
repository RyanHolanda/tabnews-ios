import Foundation

func setupInjections() {
    let injection: InjectionService = .shared
    injection.reset()

    injection.registerSingleton { HTTP(
        session: URLSession(configuration: URLSessionConfiguration.default),
        baseURL: .APIbaseUrl
    ) }

    injection.registerSingleton {
        @Injected var http: HTTP
        return ContentDataRepository(http: http) as ContentRepository
    }

    injection.registerFactory(instanceName: "date.now") {
        Date.now
    }
}
