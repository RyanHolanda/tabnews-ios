import SwiftUI

extension CommentsSection {
    static func create(ownerUsername: String, slug: String) -> CommentsSection {
        @Injected var contentRepository: ContentRepository
        return CommentsSection(
            viewModel: CommentsSectionViewModel(repository: contentRepository),
            ownerUsername: ownerUsername,
            slug: slug
        )
    }
}

struct CommentsSection: View {
    @ObservedObject var viewModel: CommentsSectionViewModel
    let ownerUsername: String
    let slug: String

    @State private var selectedComment: CommentDTO?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(.localizable.commentsSectionComments)
                    .font(.headline)
                    .bold()

                Spacer()

                Menu {
                    sortMenuItem(type: .relevants)
                    sortMenuItem(type: .recents)
                } label: {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down")
                            .rotationEffect(.degrees(viewModel.commentsListSortBy.isRelevants ? .zero : 180))
                        Text(viewModel.commentsListSortBy.label)
                    }
                }
            }

            switch viewModel.state {
            case .empty:
                Text(.localizable.noComments)
                    .padding(.top, 2)
                    .foregroundStyle(.gray)
                    .font(.subheadline)

            case .loading:
                ProgressView()
                    .padding(.top, 25)
                    .frame(maxWidth: .infinity, alignment: .center)

            case .error:
                ErrorView {
                    await viewModel.getComments(ownerUsername: ownerUsername, slug: slug)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .scaleEffect(CGSize(width: 0.85, height: 0.85))
                .padding(.top, 25)

            default:
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.comments) { comment in
                        CommentCard(comment: comment, onClickToShowReplies: {
                            selectedComment = comment
                        })
                        .padding(.vertical, 10)
                        Divider()
                    }
                }
                .sheet(item: $selectedComment) { comment in
                    CommentRepliesView.create(commentOwnerUsername: comment.ownerUsername, commentSlug: comment.slug)
                        .presentationBackground(.sheetBackground)
                }
            }
        }
        .padding(.bottom, 50)
        .task { await viewModel.getComments(ownerUsername: ownerUsername, slug: slug) }
    }

    func sortMenuItem(type: CommentsSectionListOrder) -> some View {
        Button {
            withAnimation {
                viewModel.sortComments(by: type)
            }

        } label: {
            HStack {
                Text(type.label)
                Spacer()
                if viewModel.commentsListSortBy == type { Image(systemName: "checkmark") }
            }
        }
        .disabled(viewModel.commentsListSortBy == type)
    }
}

#Preview {
    CommentsSection(
        viewModel: CommentsSectionViewModel(repository: PreviewMocks.MockContentRepository()),
        ownerUsername: "",
        slug: ""
    ).padding()
}
