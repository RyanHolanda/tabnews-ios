import SwiftUI

extension ProfileView {
    static func create(username: String?) -> ProfileView {
        @Injected var userRepository: UserRepository
        let viewModel: ProfileViewModel = .init(userRepository: userRepository)
        return ProfileView(viewModel: viewModel, username: username)
    }
}

struct ProfileView: View {
    @Injected("date.now") private var nowDate: Date
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showUsernameInNavigationTitle: Bool = false

    let username: String?

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case .error: ErrorView {
                    Task { await viewModel.getUser(username: username ?? "") }
                }
            default:
                List {
                    Section {
                        HStack {
                            Circle()
                                .frame(height: 80)
                                .overlay {
                                    Text(viewModel.user.username.first?.uppercased() ?? "")
                                        .foregroundStyle(.black)
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                }
                            VStack {
                                Text(viewModel.user.username)
                                    .font(.title3)
                                    .bold()
                                    .padding()
                                    .onAppear { showUsernameInNavigationTitle = false }
                                    .onDisappear { showUsernameInNavigationTitle = true }
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())

                    Section {
                        MarkdownBody(viewModel.user.description)
                    } header: {
                        Text("Description")
                    }

                    Rectangle()
                        .frame(height: 2000)

                    Button("Sign out", role: .destructive) {}
                }
//                .navigationTitle(showUsernameInNavigationTitle ? viewModel.user.username : " ")
//                .navigationBarTitleDisplayMode(.inline)
            }
        }
//        .padding(.top, 5)
        .toolbar(.visible, for: .tabBar)
        .task {
            if !viewModel.state.isSuccess, username != nil { await viewModel.getUser(username: username!) }
        }
    }
}

#Preview {
    ProfileView(viewModel: .init(userRepository: PreviewMocks.MockUserRepository()), username: "RyanHolanda")
}
