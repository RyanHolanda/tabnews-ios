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
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 40)
                        .task {
                            await onPaginate()
                        }
                }
            }
            .padding()
        }
        .refreshable {
            try? await Task.sleep(nanoseconds: 1000000000)
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
