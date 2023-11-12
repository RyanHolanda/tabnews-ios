@testable import TabNews
import ViewInspector
import XCTest

final class CommentCardSnapshotTest: XCTestCase {
    var sut: CommentCard?

    override func tearDown() async throws {
        sut = nil
    }

    func testCommentCard() throws {
        sut = .init(comment: CommentDTO.fixture().copyWith(replies: 12), todayDate: Date(year: 2017, month: 11, day: 11))
        Snapshooter.snapshot(sut, name: "comment_card")
    }

    func testCommentCardWithNoReplies() throws {
        sut = .init(comment: CommentDTO.fixture().copyWith(replies: 0), todayDate: Date(year: 2017, month: 11, day: 11))
        Snapshooter.snapshot(sut, name: "comment_card_no_replies")
    }
}
