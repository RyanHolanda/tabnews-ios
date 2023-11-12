import Foundation

protocol DTOProtocol: Codable, Identifiable {
    #if DEBUG
        static func fixture() -> Self
    #endif

    static func empty() -> Self
    init(from decoder: Decoder) throws
}
