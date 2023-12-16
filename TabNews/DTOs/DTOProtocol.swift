import Foundation

protocol DTOProtocol: Codable, Identifiable, Equatable {
    static func fixture() -> Self
    static func empty() -> Self
    init(from decoder: Decoder) throws
}
