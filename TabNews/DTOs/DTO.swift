import Foundation

protocol DTO: Codable, Identifiable, Equatable {
    static func fixture() -> Self
    static func empty() -> Self
    init(from decoder: Decoder) throws
}
