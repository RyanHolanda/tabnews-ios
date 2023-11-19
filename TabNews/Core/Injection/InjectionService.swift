// swiftlint:disable force_cast
import Foundation

@propertyWrapper
struct Injected<T> {
    init(_ key: String? = nil) {
        self.keya = key
    }

    let keya: String?

    var wrappedValue: T {
        InjectionService[T.self, keya]
    }
}

class InjectionService {
    static let shared: InjectionService = .init()
    private static var singletons: [String: Any] = ["": ""]
    private static var factories: [String: Any] = ["": ""]

    static subscript<T>(_ key: (some Any).Type, instanceName: String?) -> T {
        if let factory = InjectionService.factories[instanceName ?? "\(key)"] {
            let value: () -> T = factory as! () -> T
            return value()
        }

        guard let singleton = InjectionService.singletons[instanceName ?? "\(key)"] else {
            fatalError("\(instanceName ?? "\(T.self)") is not registered inside Injections yet")
        }

        return singleton as! T
    }

    func registerSingleton<T>(instanceName registrationKey: String = "\(T.self)", _ value: () -> T) {
        guard InjectionService.factories[registrationKey] == nil else {
            fatalError("\(registrationKey) is already registered inside Injections")
        }

        guard InjectionService.singletons[registrationKey] == nil else {
            fatalError("\(registrationKey) is already registered inside Injections")
        }

        InjectionService.singletons[registrationKey] = value()
    }

    func registerFactory<T>(instanceName registrationKey: String = "\(T.self)", _ value: @escaping () -> T) {
        guard InjectionService.singletons[registrationKey] == nil else {
            fatalError("\(registrationKey) is already registered inside Injections")
        }

        guard InjectionService.factories[registrationKey] == nil else {
            fatalError("\(registrationKey) is already registered inside Injections")
        }

        InjectionService.factories[registrationKey] = value
    }

    func reset() {
        InjectionService.singletons.removeAll()
        InjectionService.factories.removeAll()
    }
}

// swiftlint:enable force_cast
