import Foundation

protocol UserRepository {
    func getUser(username: String) async throws -> UserDto
}

struct UserDataRepository: UserRepository {
    let http: HTTPProtocol

    func getUser(username: String) async throws -> UserDto {
        let user: UserDto = try await http.get("/users/\(username)")
        return user
    }
}
