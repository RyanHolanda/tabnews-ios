import SwiftUI

struct PostsList: View {
    let posts: [ContentPreviewDTO]
    let shouldPaginate: Bool
    let onPaginate: () async -> Void
    let onRefresh: () async -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(posts.indices, id: \.self) { index in
                    PostCard(contentPreview: posts[index])
                        .accessibilityIdentifier("post-\(index)")
                    Divider()
                }

                if shouldPaginate {
                    ForEach(0 ..< 2, id: \.self) { _ in
                        PostCard(contentPreview: .fixture())
                            .redacted(reason: .placeholder)
                            .disabled(true)

                        Divider()
                    }
                    .task {
                        await onPaginate()
                    }
                }
            }
            .padding()
        }
        .refreshable {
            await onRefresh()
        }
    }
}

#Preview {
    PostsList(
        posts: [
            ContentPreviewDTO.fixture(),
            ContentPreviewDTO.fixture(),
            ContentPreviewDTO.fixture(),
            ContentPreviewDTO.fixture()
        ],
        shouldPaginate: false
    ) {} onRefresh: {}
}
