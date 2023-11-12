import Foundation

struct ContentDTO: DTOProtocol {
    let id: String
    let ownerId: String
    let slug: String
    let title: String
    let body: String
    let createdAt: String
    let updatedAt: String
    let ownerUsername: String
    let tabcoins: Int
    let commentsCount: Int

    enum CodingKeys: String, CodingKey {
        case id, ownerId, slug, title, body, tabcoins,
             createdAt = "created_at",
             updatedAt = "updated_at",
             ownerUsername = "owner_username",
             commentsCount = "children_deep_count"
    }

    init(id: String, ownerId: String, slug: String, title: String, createdAt: String, updatedAt: String, ownerUsername: String, tabcoins: Int, commentsCount: Int, body: String) {
        self.id = id
        self.ownerId = ownerId
        self.slug = slug
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.ownerUsername = ownerUsername
        self.tabcoins = tabcoins
        self.commentsCount = commentsCount
        self.body = body
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<ContentDTO.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId) ?? ""
        slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        tabcoins = try container.decodeIfPresent(Int.self, forKey: .tabcoins) ?? 0
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
        ownerUsername = try container.decodeIfPresent(String.self, forKey: .ownerUsername) ?? ""
        commentsCount = try container.decodeIfPresent(Int.self, forKey: .commentsCount) ?? 0
    }

    static func empty() -> ContentDTO {
        ContentDTO(
            id: "",
            ownerId: "",
            slug: "",
            title: "",
            createdAt: "", updatedAt: "",
            ownerUsername: "",
            tabcoins: 0,
            commentsCount: 0,
            body: ""
        )
    }

    #if DEBUG
        static func fixture() -> ContentDTO {
            ContentDTO(
                id: "CONTENT_ID",
                ownerId: "OWNER_ID",
                slug: "5-fatos-mais-complexos-da-programacao",
                title: "5 Fatos mais complexos da programação",
                createdAt: "2010-07-23T16:12:27.009Z",
                updatedAt: "2010-07-23T16:12:27.009Z",
                ownerUsername: "homer-simpson",
                tabcoins: 3,
                commentsCount: 7,
                body: """
                #### Markdown Headline
                _Italic_
                **Bold**
                Paragraph
                [Link](http://link.com)
                """
            )
        }
    #endif
}
