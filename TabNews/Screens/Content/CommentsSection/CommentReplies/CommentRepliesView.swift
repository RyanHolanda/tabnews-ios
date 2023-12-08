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

    @EnvironmentObject var commentsSectionViewModel: CommentsSectionViewModel
    @ObservedObject var viewModel: CommentRepliesViewModel
    @State var selectedReply: CommentDTO?
    @State var isShowingReplies: Bool = false

    init(commentOwnerUsername: String, commentSlug: String, viewModel: CommentRepliesViewModel) {
        self.commentOwnerUsername = commentOwnerUsername
        self.commentSlug = commentSlug
        self.viewModel = viewModel
    }

    var body: some View {
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
                                isShowingReplies = true
                                selectedReply = reply
                            }
                            .padding(.vertical, 10)
                            Divider()
                        }
                    }
                    .padding()
                }
            }
            .accessibilityIdentifier("comment-replies-scroll")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(.localizable.answersTo(commentOwnerUsername, viewModel.replies.count))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .confirmationAction) { DismissButton {
                    commentsSectionViewModel.toggleShowCommentReplies(comment: nil)
                }.accessibilityIdentifier("dismiss-comment-replies") }
            }
            .navigationDestination(isPresented: $isShowingReplies) {
                CommentRepliesView.create(commentOwnerUsername: selectedReply?.ownerUsername ?? "", commentSlug: selectedReply?.slug ?? "")
            }
            .background(.sheetBackground)
        }
        .task { if !viewModel.state.isSuccess { await viewModel.getReplies(commentOwnerUsername: commentOwnerUsername, commentSlug: commentSlug) } }
    }
}

#Preview {
    CommentRepliesView(commentOwnerUsername: "Marge", commentSlug: "", viewModel: CommentRepliesViewModel(repository: PreviewMocks.MockContentRepository()))
}
