import SwiftUI

struct PostCard: View {
    let contentPreview: ContentPreviewDTO
    @State private var nowDate: Date = .now
    @Environment(\.scenePhase) private var scenePhase: ScenePhase

    func updateDateTime() {
        @Injected("date.now") var date: Date
        nowDate = date
    }

    var body: some View {
        LazyNavigationLink {
            ContentView.create(slug: contentPreview.slug, ownerUsername: contentPreview.ownerUsername)
        } label: {
            VStack(alignment: .leading) {
                Text("\(contentPreview.ownerUsername) • \(Date.getTimeAgo(fromISO: contentPreview.publishedAt, to: nowDate))")
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
            .onAppear { updateDateTime() }
            .onChange(of: scenePhase) { if $0 == .active { updateDateTime() } }
        }
    }
}

#Preview {
    PostCard(contentPreview: .fixture())
}
