@testable import TabNews
import XCTest

final class StringExtensionTests: XCTestCase {
    func testAPIBaseUrl() throws {
        let sut: String = .APIbaseUrl

        XCTAssert(sut == "https://www.tabnews.com.br/api/v1")
    }

    func testBaseUrl() throws {
        let sut: String = .baseUrl

        XCTAssert(sut == "https://www.tabnews.com.br")
    }
}
