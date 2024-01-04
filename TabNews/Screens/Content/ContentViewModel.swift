import Foundation

enum ContentViewState {
    case loading
    case success
    case error
}

extension ContentViewState {
    var isSuccess: Bool {
        self == .success
    }
}

@MainActor class ContentViewModel: ObservableObject {
    init(contentRepository: ContentRepository) {
        self.contentRepository = contentRepository
    }

    private let contentRepository: ContentRepository

    @Published var state: ContentViewState = .loading
    var content: ContentDTO = .empty()

    func getContent(ownerUsername: String, slug: String) async {
        do {
            state = .loading
            content = try await contentRepository.getPost(ownerUsername: ownerUsername, slug: slug)
            state = .success
        } catch {
            state = .error
            Logger.logError(error: error, description: "Failed to get Content")
        }
    }
}
