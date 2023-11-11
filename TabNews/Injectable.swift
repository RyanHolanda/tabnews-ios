import Foundation

protocol SingletonInjectable {
    associatedtype Value
    static var injectionValue: Self.Value { get }
}

protocol FactoryInjectable {
    associatedtype Value
    var injectionValue: Self.Value { get }
    init()
}

class InjectedValues {
    private static var instance: InjectedValues = .init()

    static subscript<T>(_ key: T.Type) -> T.Value where T: FactoryInjectable {
        key.init().injectionValue
    }

    static subscript<T>(_ key: T.Type) -> T.Value where T: SingletonInjectable {
        key.injectionValue
    }

    static subscript<T>(_ key: KeyPath<InjectedValues, T>) -> T { instance[keyPath: key] }

    var contentRepository: ContentRepository {
        struct ContentRepositoryKey: SingletonInjectable {
            @Injected(\.http) static var http: HTTP
            static var injectionValue: ContentRepository = ContentDataRepository(http: http)
        }
        return InjectedValues[ContentRepositoryKey.self]
    }

    var http: HTTP {
        struct HTTPKey: SingletonInjectable {
            static var injectionValue: HTTP = .init(
                session: URLSession(configuration: URLSessionConfiguration.default),
                baseURL: .APIbaseUrl
            )
        }
        return InjectedValues[HTTPKey.self]
    }
}

@propertyWrapper
struct Injected<T> {
    let key: KeyPath<InjectedValues, T>
    var wrappedValue: T {
        return InjectedValues[key]
    }

    init(_ key: KeyPath<InjectedValues, T>) {
        self.key = key
    }
}
