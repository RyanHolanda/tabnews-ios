import SwiftUI

extension CommentRepliesView {
    static func create(commentOwnerUsername: String, commentSlug: String) -> CommentRepliesView {
        @Injected var contentRepository: ContentRepository
        return CommentRepliesView(commentOwnerUsername: commentOwnerUsername, commentSlug: commentSlug, viewModel: CommentRepliesViewModel(repository: contentRepository))
    }
}

struct CommentRepliesView: View {
    let commentOwnerUsername: String
    let commentSlug: String
    @ObservedObject var viewModel: CommentRepliesViewModel
    @State var selectedReply: CommentDTO?

    init(commentOwnerUsername: String, commentSlug: String, viewModel: CommentRepliesViewModel) {
        self.commentOwnerUsername = commentOwnerUsername
        self.commentSlug = commentSlug
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    switch viewModel.state {
                    case .loading:
                        ProgressView()
                            .frame(width: geometry.size.width, height: geometry.size.height)

                    case .error:
                        ErrorView { await viewModel.getReplies(commentOwnerUsername: commentOwnerUsername, commentSlug: commentSlug) }
                            .frame(width: geometry.size.width, height: geometry.size.height)

                    default: LazyVStack(alignment: .leading) {
                            ForEach(viewModel.replies) { reply in
                                CommentCard(comment: reply) {
                                    selectedReply = reply
                                }
                                .padding(.vertical, 10)
                                Divider()
                            }
                        }
                        .padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(.localizable.answersTo(commentOwnerUsername, viewModel.replies.count))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    ToolbarItem(placement: .confirmationAction) { DismissButton() }
                }
            }
        }
        .sheet(item: $selectedReply) { reply in
            CommentRepliesView.create(commentOwnerUsername: reply.ownerUsername, commentSlug: reply.slug)
                .presentationBackground(.sheetBackground)
        }
        .task { await viewModel.getReplies(commentOwnerUsername: commentOwnerUsername, commentSlug: commentSlug) }
    }
}

#Preview {
    CommentRepliesView(commentOwnerUsername: "Marge", commentSlug: "", viewModel: CommentRepliesViewModel(repository: PreviewMocks.MockContentRepository()))
}
