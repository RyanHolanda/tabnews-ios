import Foundation

enum RecentsViewState {
    case initial
    case loading
    case success
    case error
    case paginationError
    case paginationLoading
    case refreshed
}

@MainActor class RecentsViewModel: ObservableObject {
    init(repository: ContentRepository) {
        self.repository = repository
    }

    private let repository: ContentRepository

    var posts: [ContentPreviewDTO] = []
    private let itemsPerPage: Int = 40
    private var currentPage: Int = 1
    var hasMoreItems: Bool = true
    @Published var state: RecentsViewState = .initial

    func paginateData() async {
        do {
            currentPage += 1
            state = .paginationLoading
            let newPosts: [ContentPreviewDTO] = try await repository.getRecentsPosts(page: currentPage, perPage: itemsPerPage)
            if newPosts.count < itemsPerPage {
                hasMoreItems = false
            }
            posts.append(contentsOf: newPosts)
            state = .success
        } catch {
            Logger.logError(error: error)
            state = .paginationError
            currentPage -= 1
        }
    }

    func refreshPosts() async {
        do {
            posts = try await repository.getRecentsPosts(page: 1, perPage: itemsPerPage)
            state = .refreshed
        } catch {
            Logger.logError(error: error)
            state = .error
        }
    }

    func fetchRecentsPosts() async {
        do {
            state = .loading
            posts = try await repository.getRecentsPosts(page: 1, perPage: itemsPerPage)
            if posts.count < itemsPerPage {
                hasMoreItems = false
            }
            state = .success
        } catch {
            Logger.logError(error: error)
            state = .error
        }
    }
}
