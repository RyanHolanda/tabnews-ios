import Foundation

enum ContentResponses {
    static let longBody: [String: Any] = [
        "id": "66245063-f7ce-44bc-84ed-fb6ef026a87a",
        "owner_id": "3b7a787f-57af-4038-8f69-62fa5ee218b1",
        "slug": "hackeando-seus-habitos",
        "title": "Hackeando seus hábitos",
        "body": """
        ![Mock image](http://localhost:8080/image)
        ```
        .codeBlock { label in
              ScrollView(.horizontal) {
                label
                  .relativeLineSpacing(.em(0.25))
                  .markdownTextStyle {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.85))
                  }
                  .padding()
              }
              .background(Color(.secondarySystemBackground))
              .clipShape(RoundedRectangle(cornerRadius: 8))
              .markdownMargin(top: .zero, bottom: .em(0.8))
            }
        ````
        """,
        "status": "published",
        "created_at": "2023-12-04T10:31:33.761Z",
        "updated_at": "2023-12-04T10:31:33.761Z",
        "published_at": "2023-12-04T10:31:33.804Z",
        "owner_username": "moacirmoda",
        "tabcoins": 29,
        "children_deep_count": 5
    ]
}
