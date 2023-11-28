import SwiftUI

struct CommentCard: View {
    let comment: CommentDTO
    @State private var nowDate: Date = .now
    @Environment(\.scenePhase) private var scenePhase: ScenePhase
    let onClickToShowReplies: () -> Void

    func updateDateTime() {
        @Injected("date.now") var date: Date
        nowDate = date
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("""
            \(comment.ownerUsername) • \(Date.getTimeAgo(fromISO: comment.publishedAt, to: nowDate)) • \(.localizable.tabcoins(comment.tabcoins))
            """)
            .foregroundStyle(.gray)
            .font(.system(size: 14))
            .bold()
            .multilineTextAlignment(.leading)

            ExpandableMarkdownBody(comment.body)
                .padding(.top, 2)

            if comment.replies > 0 {
                Button {
                    onClickToShowReplies()
                } label: {
                    HStack {
                        Image(systemName: "chevron.down")
                        Text(.localizable.answers(comment.replies))
                            .font(.subheadline)
                    }
                }
                .padding(.top, 5)
            }
        }
        .onAppear { updateDateTime() }
        .onChange(of: scenePhase) { if $0 == .active { updateDateTime() } }
    }
}

#Preview {
    CommentCard(comment: CommentDTO.fixture().copyWith(replies: 29)) {}
}
