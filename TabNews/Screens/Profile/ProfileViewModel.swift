import Foundation

enum ProfileViewState {
    case loading
    case success
    case error
    case loggedOut
}

extension ProfileViewState {
    var isSuccess: Bool {
        self == .success
    }
}

@MainActor
class ProfileViewModel: ObservableObject {
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    private let userRepository: UserRepository

    @Published var state: ProfileViewState = .loading
    var user: UserDto = .empty()

    func getUser(username: String, emitLoading: Bool = true) async {
        do {
            if emitLoading { state = .loading }
            user = try await userRepository.getUser(username: username)
            state = .success
        } catch {
            Logger.logError(error: error, description: "Failed to get user")
            state = .error
        }
    }
}
