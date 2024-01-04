import Foundation

enum CommentsSectionState {
    case loading
    case success
    case error
    case empty
}

extension CommentsSectionState {
    var isSuccess: Bool {
        self == .success
    }
}

enum CommentsSectionListOrder: Int {
    case relevants
    case recents
}

extension CommentsSectionListOrder {
    var value: String {
        ["relevants", "recents"][rawValue]
    }

    var label: String {
        [String(localized: .localizable.relevants), String(localized: .localizable.recents)][rawValue]
    }

    var isRelevants: Bool {
        self == .relevants
    }

    var isRecents: Bool {
        self == .recents
    }
}

@MainActor class CommentsSectionViewModel: ObservableObject {
    init(repository: ContentRepository) {
        self.repository = repository
    }

    private let repository: ContentRepository

    @Published var state: CommentsSectionState = .loading
    @Published var commentsListSortBy: CommentsSectionListOrder = .relevants
    @Published var isShowingCommentRepliesSheet: Bool = false
    var showingRepliesComment: CommentDTO?

    var comments: [CommentDTO] = []

    func toggleShowCommentReplies(comment: CommentDTO?) {
        showingRepliesComment = comment
        isShowingCommentRepliesSheet.toggle()
    }

    func getComments(ownerUsername: String, slug: String) async {
        do {
            state = .loading
            comments = try await repository.getComments(ownerUsername: ownerUsername, slug: slug)
            sortComments(by: commentsListSortBy)
            state = comments.isEmpty ? .empty : .success
        } catch {
            Logger.logError(error: error, description: "Failed to get comments")
            state = .error
        }
    }

    func sortComments(by sortBy: CommentsSectionListOrder) {
        switch sortBy {
        case .recents: comments.sort {
                $0.publishedAt > $1.publishedAt
            }
        case .relevants: comments.sort {
                $0.tabcoins > $1.tabcoins
            }
        }
        commentsListSortBy = sortBy
    }
}
