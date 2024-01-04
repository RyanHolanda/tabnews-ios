import Foundation

struct UserDto: DTO {
    let id: String
    let username: String
    let description: String
    let tabcoins: Int
    let tabcash: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case description
        case tabcoins
        case tabcash
        case createdAt = "created_at"
    }

    static func fixture() -> UserDto {
        UserDto(
            id: "7db6c97a-3e1f-4417-863d-6df2773f8dac",
            username: "RyanHolanda",
            description: "Hello! I'm a TabNews User",
            tabcoins: 234,
            tabcash: 21,
            createdAt: "2010-11-25T22:21:17.146Z"
        )
    }

    static func empty() -> UserDto {
        UserDto(id: "", username: "", description: "", tabcoins: 0, tabcash: 0, createdAt: "")
    }
}
