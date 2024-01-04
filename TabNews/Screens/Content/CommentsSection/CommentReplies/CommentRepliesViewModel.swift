import Foundation

enum CommentRepliesState {
    case loading
    case error
    case success
}

extension CommentRepliesState {
    var isSuccess: Bool {
        self == .success
    }
}

@MainActor
class CommentRepliesViewModel: ObservableObject {
    init(repository: ContentRepository) {
        self.repository = repository
    }

    private let repository: ContentRepository

    @Published var state: CommentRepliesState = .loading
    var replies: [CommentDTO] = []

    func getReplies(commentOwnerUsername: String, commentSlug: String) async {
        do {
            state = .loading
            replies = try await repository.getComments(ownerUsername: commentOwnerUsername, slug: commentSlug)
            state = .success
        } catch {
            state = .error
            Logger.logError(error: error, description: "Failed to get Comment Replies")
        }
    }

    func refreshReplies() {}

    func sortReplies() {}
}
