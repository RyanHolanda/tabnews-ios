import Foundation

struct ContentDTO: DTO {
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
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId) ?? ""
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        self.tabcoins = try container.decodeIfPresent(Int.self, forKey: .tabcoins) ?? 0
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
        self.ownerUsername = try container.decodeIfPresent(String.self, forKey: .ownerUsername) ?? ""
        self.commentsCount = try container.decodeIfPresent(Int.self, forKey: .commentsCount) ?? 0
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

    func copyWith(id: String? = nil, ownerId: String? = nil, slug: String? = nil, title: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, ownerUsername: String? = nil, tabcoins: Int? = nil, commentsCount: Int? = nil, body: String? = nil) -> ContentDTO {
        ContentDTO(
            id: id ?? self.id,
            ownerId: ownerId ?? self.ownerId,
            slug: slug ?? self.slug,
            title: title ?? self.title,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            ownerUsername: ownerUsername ?? self.ownerUsername,
            tabcoins: tabcoins ?? self.tabcoins,
            commentsCount: commentsCount ?? self.commentsCount,
            body: body ?? self.body
        )
    }

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
}
