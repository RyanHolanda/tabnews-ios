import Foundation

struct CommentDTO: DTOProtocol, Hashable {
    let id: String
    let ownerId: String
    let parentId: String
    let slug: String
    let body: String
    let publishedAt: String
    let updatedAt: String
    let ownerUsername: String
    let tabcoins: Int
    let children: [CommentDTO]
    let replies: Int

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case parentId = "parent_id"
        case slug
        case body
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case ownerUsername = "owner_username"
        case tabcoins
        case children
        case replies = "children_deep_count"
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CommentDTO.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId) ?? ""
        self.parentId = try container.decodeIfPresent(String.self, forKey: .parentId) ?? ""
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
        self.ownerUsername = try container.decodeIfPresent(String.self, forKey: .ownerUsername) ?? ""
        self.tabcoins = try container.decodeIfPresent(Int.self, forKey: .tabcoins) ?? 0
        self.children = try container.decodeIfPresent([CommentDTO].self, forKey: .children) ?? []
        self.replies = try container.decodeIfPresent(Int.self, forKey: .replies) ?? 0
    }

    init(id: String, ownerId: String, parentId: String, slug: String, body: String, publishedAt: String, updatedAt: String, ownerUsername: String, tabcoins: Int, children: [CommentDTO], replies: Int) {
        self.id = id
        self.ownerId = ownerId
        self.parentId = parentId
        self.slug = slug
        self.body = body
        self.publishedAt = publishedAt
        self.updatedAt = updatedAt
        self.ownerUsername = ownerUsername
        self.tabcoins = tabcoins
        self.children = children
        self.replies = replies
    }

    func copyWith(id: String? = nil, ownerId: String? = nil, parentId: String? = nil, slug: String? = nil, body: String? = nil, publishedAt: String? = nil, updatedAt: String? = nil, ownerUsername: String? = nil, tabcoins: Int? = nil, children: [CommentDTO]? = nil, replies: Int? = nil) -> CommentDTO {
        CommentDTO(
            id: id ?? self.id,
            ownerId: ownerId ?? self.ownerId,
            parentId: parentId ?? self.parentId,
            slug: slug ?? self.slug,
            body: body ?? self.body,
            publishedAt: publishedAt ?? self.publishedAt,
            updatedAt: updatedAt ?? self.updatedAt,
            ownerUsername: ownerUsername ?? self.ownerUsername,
            tabcoins: tabcoins ?? self.tabcoins,
            children: children ?? self.children,
            replies: replies ?? self.replies
        )
    }

    static func fixture() -> CommentDTO {
        CommentDTO(
            id: UUID().uuidString,
            ownerId: "OWNER_ID",
            parentId: "PARENT_ID",
            slug: "SLUG",
            body: """
            Parabéns pela clareza da documentação! O interessante é que, um material desse,
            pode ser um ótimo treinamento com dados reais, gerando programa real, que realmente faz algo.
            """,
            publishedAt: "2010-11-25T22:21:17.146Z",
            updatedAt: "2010-11-25T22:21:17.146Z",
            ownerUsername: "marge-simpson",
            tabcoins: 123,
            children: [],
            replies: 0
        )
    }

    static func empty() -> CommentDTO {
        CommentDTO(
            id: "",
            ownerId: "",
            parentId: "", slug: "",
            body: "",
            publishedAt: "",
            updatedAt: "",
            ownerUsername: "",
            tabcoins: 0,
            children: [],
            replies: 0
        )
    }
}
