import SwiftUI

extension ContentView {
    static func create(slug: String, ownerUsername: String) -> ContentView {
        @Injected(\.contentRepository) var contentRepository: ContentRepository
        let viewModel: ContentViewModel = .init(contentRepository: contentRepository)
        return ContentView(viewModel: viewModel, slug: slug, ownerUsername: ownerUsername, todayDate: .now)
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    let slug: String
    let ownerUsername: String
    let todayDate: Date

    var body: some View {
        switch viewModel.state {
        case .loading: ProgressView().onAppear {
                Task {
                    await viewModel.getContent(ownerUsername: ownerUsername, slug: slug)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        case .error: ErrorView {
                Task {
                    await viewModel.getContent(ownerUsername: ownerUsername, slug: slug)
                }
            }
            .navigationBarTitleDisplayMode(.inline)

        default:
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text("\(viewModel.content.ownerUsername) • \(Date.getTimeAgo(fromISO: viewModel.content.createdAt, to: todayDate))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)
                        .foregroundStyle(.gray)

                    Text(viewModel.content.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.trailing, 40)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    MarkdownBody(viewModel.content.body)
                        .padding(.top, 10)

                    CommentsSection.create(
                        ownerUsername: viewModel.content.ownerUsername,
                        slug: viewModel.content.slug
                    )
                    .padding(.top, 70)
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.content.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .frame(width: 200)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    ShareLink(item: "\(String.baseUrl)/\(viewModel.content.ownerUsername)/\(viewModel.content.slug)") {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView(
            viewModel: ContentViewModel(contentRepository: PreviewMocks.MockContentRepository()),
            slug: "",
            ownerUsername: "",
            todayDate: .now
        )
    }
}
