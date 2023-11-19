import SwiftUI

extension RelevantsView {
    static func create() -> RelevantsView {
        @Injected var repository: ContentRepository
        let viewModel: RelevantsViewModel = .init(repository: repository)
        return RelevantsView(viewModel: viewModel)
    }
}

struct RelevantsView: View {
    @ObservedObject var viewModel: RelevantsViewModel

    init(viewModel: RelevantsViewModel) {
        self.viewModel = viewModel
        Task {
            await viewModel.fetchRelevantsPosts()
        }
    }

    @State var isShowingPostSheet: Bool = false

    func openPost() {
        isShowingPostSheet = true
    }

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case .error: ErrorView {
                    Task {
                        await viewModel.fetchRelevantsPosts()
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
                .navigationTitle(String(localized: .localizable.relevantsViewRelevants))
            }
        }
    }
}

#Preview {
    RelevantsView(viewModel: RelevantsViewModel(repository: PreviewMocks.MockContentRepository()))
}
