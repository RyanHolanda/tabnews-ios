import Foundation

struct ContentPreviewDTO: DTOProtocol {
    let id: String
    let ownerId: String
    let parentId: String
    let slug: String
    let title: String
    let publishedAt: String
    let ownerUsername: String
    let tabcoins: Int
    let comentsCount: Int

    enum CodingKeys: String, CodingKey {
        case slug, title,
             tabcoins, id,
             ownerId = "owner_id",
             parentId = "parent_id",
             publishedAt = "published_at",
             ownerUsername = "owner_username",
             comentsCount = "children_deep_count"
    }

    init(id: String, ownerId: String, parentId: String, slug: String, title: String, publishedAt: String, ownerUsername: String, tabcoins: Int, comentsCount: Int) {
        self.id = id
        self.ownerId = ownerId
        self.parentId = parentId
        self.slug = slug
        self.title = title
        self.publishedAt = publishedAt
        self.ownerUsername = ownerUsername
        self.tabcoins = tabcoins
        self.comentsCount = comentsCount
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<ContentPreviewDTO.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId) ?? ""
        self.parentId = try container.decodeIfPresent(String.self, forKey: .parentId) ?? ""
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        self.ownerUsername = try container.decodeIfPresent(String.self, forKey: .ownerUsername) ?? ""
        self.tabcoins = try container.decodeIfPresent(Int.self, forKey: .tabcoins) ?? 0
        self.comentsCount = try container.decodeIfPresent(Int.self, forKey: .comentsCount) ?? 0
    }

    static func empty() -> ContentPreviewDTO {
        ContentPreviewDTO(
            id: "",
            ownerId: "",
            parentId: "",
            slug: "",
            title: "",
            publishedAt: "",
            ownerUsername: "",
            tabcoins: 0,
            comentsCount: 0
        )
    }

    #if DEBUG
        static func fixture() -> ContentPreviewDTO {
            ContentPreviewDTO(
                id: "id",
                ownerId: "owner_id",
                parentId: "parent_id",
                slug: "slug",
                title: "Curadoria coletiva de conteúdos sobre performance",
                publishedAt: "2010-10-19T19:48:49.497Z",
                ownerUsername: "homer-simpson",
                tabcoins: 0,
                comentsCount: 0
            )
        }
    #endif
}
