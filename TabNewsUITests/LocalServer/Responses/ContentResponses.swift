import Foundation

enum ContentResponses {
    static let longBody: [String: Any] = [
        "id": "66245063-f7ce-44bc-84ed-fb6ef026a87a",
        "owner_id": "3b7a787f-57af-4038-8f69-62fa5ee218b1",
        "slug": "hackeando-seus-habitos",
        "title": "Hackeando seus hábitos",
        "body": """
        Hábitos são comportamentos ou padrões de ação que uma pessoa adquire através da repetição frequente de uma atividade. É aquilo que você faz todo santo dia.\n\nTodo mundo tem seus hábitos. Acontece que, na grande maioria dos casos, esses hábitos foram desenvolvidos de forma não-intencional e, por isso, quase sempre são maus hábitos.\n\nHoje eu decidi contar um pouco mais sobre a minha história com os hábitos e também te dar algumas dicas para você iniciar um novo hábito da melhor forma possível.\n\nVamos lá?\n\n\n# O começo de tudo\n\nO ano era 2015 e eu comecei a ganhar um bom dinheiro. Nessa época eu trabalhava como freelancer. Através de uma indicação, caí em um job que acabou virando um emprego. Os caras estavam com um baita problema para colocar um software importante em produção. Eu consegui resolver o problema. Diante do valor gerado, me ofereceram uma posição fixa no time. Aceitei. \"Do dia para a noite\" saltei para um ganho de R$ 10k/mês.
        Hábitos são comportamentos ou padrões de ação que uma pessoa adquire através da repetição frequente de uma atividade. É aquilo que você faz todo santo dia.\n\nTodo mundo tem seus hábitos. Acontece que, na grande maioria dos casos, esses hábitos foram desenvolvidos de forma não-intencional e, por isso, quase sempre são maus hábitos.\n\nHoje eu decidi contar um pouco mais sobre a minha história com os hábitos e também te dar algumas dicas para você iniciar um novo hábito da melhor forma possível.\n\nVamos lá?\n\n\n# O começo de tudo\n\nO ano era 2015 e eu comecei a ganhar um bom dinheiro. Nessa época eu trabalhava como freelancer. Através de uma indicação, caí em um job que acabou virando um emprego. Os caras estavam com um baita problema para colocar um software importante em produção. Eu consegui resolver o problema. Diante do valor gerado, me ofereceram uma posição fixa no time. Aceitei. \"Do dia para a noite\" saltei para um ganho de R$ 10k/mês.
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
