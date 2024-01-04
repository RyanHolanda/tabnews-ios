import Cuckoo
@testable import TabNews
import XCTest

final class UserRepositoryUnitTests: XCTestCase {
    var sut: UserRepository?
    var http: MockHTTPProtocol?

    override func setUp() async throws {
        http = MockHTTPProtocol()
        sut = UserDataRepository(http: http!)
    }

    func testGetUser() async throws {
        let username: String = "username"

        stub(http!) { stub in
            when(stub.get(any())).thenReturn(UserDto.fixture())
        }

        let _: UserDto = try await sut!.getUser(username: username)

        verify(http!, times(1)).get("/users/\(username)").with(returnType: UserDto.self)
    }
}
