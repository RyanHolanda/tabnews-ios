import SwiftUI

extension RecentsView {
    static func create() -> RecentsView {
        @Injected(\.contentRepository) var repository: ContentRepository
        let viewModel: RecentsViewModel = .init(repository: repository)
        return RecentsView(viewModel: viewModel, todayDate: Date.now)
    }
}

struct RecentsView: View {
    @ObservedObject var viewModel: RecentsViewModel
    let todayDate: Date

    init(viewModel: RecentsViewModel, todayDate: Date) {
        self.viewModel = viewModel
        self.todayDate = todayDate
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
                    shouldPaginate: viewModel.hasMoreItems && !viewModel.posts.isEmpty,
                    todayDate: todayDate
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
    RecentsView(viewModel: RecentsViewModel(repository: PreviewMocks.MockContentRepository()), todayDate: Date.now)
}
