import SwiftUI

extension ContentView {
    static func create(slug: String, ownerUsername: String) -> ContentView {
        @Injected var contentRepository: ContentRepository
        let viewModel: ContentViewModel = .init(contentRepository: contentRepository)
        return ContentView(viewModel: viewModel, slug: slug, ownerUsername: ownerUsername)
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    let slug: String
    let ownerUsername: String
    @Injected("date.now") private var nowDate: Date

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                switch viewModel.state {
                case .loading: ProgressView()
                    .navigationBarTitleDisplayMode(.inline)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                case .error: ErrorView {
                        Task { await viewModel.getContent(ownerUsername: ownerUsername, slug: slug) }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                default:
                    VStack(alignment: .leading) {
                        Text("\(viewModel.content.ownerUsername) • \(Date.getTimeAgo(fromISO: viewModel.content.createdAt, to: nowDate))")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.bottom, 2)
                            .foregroundStyle(.gray)

                        Text(viewModel.content.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.trailing, 40)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityIdentifier("content-title")

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
                            .accessibilityIdentifier("share-post")
                        }
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .task { await viewModel.getContent(ownerUsername: ownerUsername, slug: slug) }
    }
}

#Preview {
    NavigationStack {
        ContentView(
            viewModel: ContentViewModel(contentRepository: PreviewMocks.MockContentRepository()),
            slug: "",
            ownerUsername: ""
        )
    }
}
