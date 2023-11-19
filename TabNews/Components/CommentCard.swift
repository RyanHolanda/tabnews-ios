import SwiftUI

struct CommentCard: View {
    let comment: CommentDTO
    @Injected("date.now") var nowDate: Date

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
                Button {} label: {
                    HStack {
                        Image(systemName: "chevron.down")
                        Text(.localizable.answers(comment.replies))
                            .font(.subheadline)
                    }
                }.padding(.top, 5)
            }
        }
    }
}

#Preview {
    CommentCard(comment: CommentDTO.fixture().copyWith(replies: 29))
}
