@testable import TabNews
import XCTest

final class InjectionServiceUnitTests: XCTestCase {
    var sut: InjectionService?

    override func setUp() async throws {
        sut = InjectionService.shared
    }

    override func tearDown() async throws {
        sut = nil
    }

    func testSingletonInjection() async throws {
        class SingletonClass {
            var sutNumber: Int = 0
        }

        sut!.registerSingleton {
            SingletonClass()
        }

        @Injected var injectedSingletonClassA: SingletonClass
        injectedSingletonClassA.sutNumber = 7
        @Injected var injectedSingletonClassB: SingletonClass

        XCTAssertEqual(injectedSingletonClassA.sutNumber, 7)
        XCTAssertEqual(injectedSingletonClassB.sutNumber, 7)
    }

    func testFactoryInjection() async throws {
        class FactoryClass {
            var sutNumber: Int = 0
        }

        sut?.registerFactory {
            FactoryClass()
        }

        @Injected var injectedFactoryClassA: FactoryClass
        injectedFactoryClassA.sutNumber = 7
        @Injected var injectedFactoryClassB: FactoryClass
        injectedFactoryClassB.sutNumber = 2

        XCTAssertEqual(injectedFactoryClassA.sutNumber, 0)
        XCTAssertEqual(injectedFactoryClassB.sutNumber, 0)
    }

    func testNamedFactoryInjection() async throws {
        class FactoryClass {
            var sutNumber: Int = 0
        }

        sut?.registerFactory(instanceName: "factory") {
            FactoryClass()
        }

        @Injected("factory") var injectedFactoryClassA: FactoryClass
        injectedFactoryClassA.sutNumber = 7
        @Injected("factory") var injectedFactoryClassB: FactoryClass
        injectedFactoryClassB.sutNumber = 2

        XCTAssertEqual(injectedFactoryClassA.sutNumber, 0)
        XCTAssertEqual(injectedFactoryClassB.sutNumber, 0)
    }

    func testNamedSingletonInjection() async throws {
        class SingletonClass {
            var sutNumber: Int = 0
        }

        sut!.registerSingleton(instanceName: "singleton") {
            SingletonClass()
        }

        @Injected("singleton") var injectedSingletonClassA: SingletonClass
        injectedSingletonClassA.sutNumber = 7
        @Injected("singleton") var injectedSingletonClassB: SingletonClass

        XCTAssertEqual(injectedSingletonClassA.sutNumber, 7)
        XCTAssertEqual(injectedSingletonClassB.sutNumber, 7)
    }
}
