import SwiftUI

extension RecentsView {
    static func create() -> RecentsView {
        @Injected var repository: ContentRepository
        let viewModel: RecentsViewModel = .init(repository: repository)
        return RecentsView(viewModel: viewModel)
    }
}

struct RecentsView: View {
    @ObservedObject var viewModel: RecentsViewModel

    init(viewModel: RecentsViewModel) {
        self.viewModel = viewModel
        Task {
            await viewModel.fetchRecentsPosts()
        }
    }

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case .error: ErrorView {
                    Task {
                        await viewModel.fetchRecentsPosts()
                    }
                }
            default: PostsList(
                    posts: viewModel.posts,
                    shouldPaginate: viewModel.hasMoreItems && !viewModel.posts.isEmpty
                ) {
                    await viewModel.paginateData()
                }
                onRefresh: {
                    await viewModel.refreshPosts()
                }
                .navigationTitle(String(localized: .localizable.recentsViewRecents))
            }
        }
    }
}

#Preview {
    RecentsView(viewModel: RecentsViewModel(repository: PreviewMocks.MockContentRepository()))
}
