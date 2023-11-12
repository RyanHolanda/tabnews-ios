import SwiftUI

extension CommentsSection {
    static func create(ownerUsername: String, slug: String) -> CommentsSection {
        @Injected(\.contentRepository) var contentRepository: ContentRepository
        return CommentsSection(
            viewModel: CommentsSectionViewModel(repository: contentRepository),

            todayDate: .now,
            ownerUsername: ownerUsername,
            slug: slug
        )
    }
}

struct CommentsSection: View {
    @ObservedObject var viewModel: CommentsSectionViewModel
    let todayDate: Date
    let ownerUsername: String
    let slug: String

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
                    .task {
                        try? await Task.sleep(nanoseconds: 1_500_000_000)
                        await viewModel.getComments(ownerUsername: ownerUsername, slug: slug)
                    }

            case .error:
                ErrorView {
                    await viewModel.getComments(ownerUsername: ownerUsername, slug: slug)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .scaleEffect(CGSize(width: 0.85, height: 0.85))
                .padding(.top, 25)
            case .success:
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.comments) { comment in
                        CommentCard(comment: comment, todayDate: todayDate)
                            .padding(.vertical, 10)
                        Divider()
                    }
                }
            }
        }
        .padding(.bottom, 50)
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
        todayDate: .now,
        ownerUsername: "",
        slug: ""
    ).padding()
}
