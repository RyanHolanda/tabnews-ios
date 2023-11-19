@testable import TabNews
import ViewInspector
import XCTest

final class CommentCardSnapshotTest: XCTestCase {
    var sut: CommentCard?

    override func setUp() async throws {
        InjectionService.shared.registerFactory(instanceName: "date.now") {
            Date(year: 2017, month: 11, day: 11)
        }
    }

    override func tearDown() async throws {
        sut = nil
        InjectionService.shared.reset()
    }

    func testCommentCard() throws {
        sut = .init(comment: CommentDTO.fixture().copyWith(replies: 12))
        Snapshooter.snapshot(sut, name: "comment_card")
    }

    func testCommentCardWithNoReplies() throws {
        sut = .init(comment: CommentDTO.fixture().copyWith(replies: 0))
        Snapshooter.snapshot(sut, name: "comment_card_no_replies")
    }
}
