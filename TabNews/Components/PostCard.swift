import SwiftUI

struct PostCard: View {
    let contentPreview: ContentPreviewDTO
    let todayDate: Date

    var body: some View {
        LazyNavigationLink {
            ContentView.create(slug: contentPreview.slug, ownerUsername: contentPreview.ownerUsername)
        } label: {
            VStack(alignment: .leading) {
                Text("\(contentPreview.ownerUsername) • \(Date.getTimeAgo(fromISO: contentPreview.publishedAt, to: todayDate))")
                    .foregroundStyle(.gray)
                    .font(.system(size: 12))
                    .bold()

                Text(contentPreview.title)
                    .padding(.top, 5)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.foreground)

                Text("\(.localizable.comments(contentPreview.comentsCount)) • \(.localizable.tabcoins(contentPreview.tabcoins))")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.top, 15)
            }
            .padding(.vertical)
            .background(.clear)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    PostCard(contentPreview: .fixture(), todayDate: Date.now)
}
