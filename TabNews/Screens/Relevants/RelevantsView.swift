import SwiftUI

extension RelevantsView {
    static func create() -> RelevantsView {
        @Injected(\.contentRepository) var repository: ContentRepository
        let viewModel: RelevantsViewModel = .init(repository: repository)
        return RelevantsView(viewModel: viewModel, todayDate: Date.now)
    }
}

struct RelevantsView: View {
    @ObservedObject var viewModel: RelevantsViewModel
    let todayDate: Date

    init(viewModel: RelevantsViewModel, todayDate: Date) {
        self.viewModel = viewModel
        self.todayDate = todayDate
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
                    shouldPaginate: viewModel.hasMoreItems && !viewModel.posts.isEmpty,
                    todayDate: todayDate
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
    RelevantsView(viewModel: RelevantsViewModel(repository: PreviewMocks.MockContentRepository()), todayDate: Date.now)
}
