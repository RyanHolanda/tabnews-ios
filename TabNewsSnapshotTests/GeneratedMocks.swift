// MARK: - Mocks generated from file: TabNews/Repositories/ContentRepository.swift at 2023-12-08 11:02:11 PM +0000

import Cuckoo
@testable import TabNews

import Foundation

class MockContentRepository: ContentRepository, Cuckoo.ProtocolMock {
    typealias MocksType = ContentRepository

    typealias Stubbing = __StubbingProxy_ContentRepository
    typealias Verification = __VerificationProxy_ContentRepository

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: ContentRepository?

    func enableDefaultImplementation(_ stub: ContentRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    func getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO] {
        await try await cuckoo_manager.callThrows(
            """
            getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
            """,
            parameters: (page, perPage),
            escapingParameters: (page, perPage),
            superclassCall:

            Cuckoo.MockManager.crashOnProtocolSuperclassCall(),

            defaultCall: __defaultImplStub!.getRecentsPosts(page: page, perPage: perPage)
        )
    }

    func getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO] {
        await try await cuckoo_manager.callThrows(
            """
            getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
            """,
            parameters: (page, perPage),
            escapingParameters: (page, perPage),
            superclassCall:

            Cuckoo.MockManager.crashOnProtocolSuperclassCall(),

            defaultCall: __defaultImplStub!.getRelevantsPosts(page: page, perPage: perPage)
        )
    }

    func getPost(ownerUsername: String, slug: String) async throws -> ContentDTO {
        await try await cuckoo_manager.callThrows(
            """
            getPost(ownerUsername: String, slug: String) async throws -> ContentDTO
            """,
            parameters: (ownerUsername, slug),
            escapingParameters: (ownerUsername, slug),
            superclassCall:

            Cuckoo.MockManager.crashOnProtocolSuperclassCall(),

            defaultCall: __defaultImplStub!.getPost(ownerUsername: ownerUsername, slug: slug)
        )
    }

    func getComments(ownerUsername: String, slug: String) async throws -> [CommentDTO] {
        await try await cuckoo_manager.callThrows(
            """
            getComments(ownerUsername: String, slug: String) async throws -> [CommentDTO]
            """,
            parameters: (ownerUsername, slug),
            escapingParameters: (ownerUsername, slug),
            superclassCall:

            Cuckoo.MockManager.crashOnProtocolSuperclassCall(),

            defaultCall: __defaultImplStub!.getComments(ownerUsername: ownerUsername, slug: slug)
        )
    }

    struct __StubbingProxy_ContentRepository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }

        func getRecentsPosts<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, perPage: M2) -> Cuckoo.ProtocolStubThrowingFunction<(Int, Int), [ContentPreviewDTO]> where M1.MatchedType == Int, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: perPage) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(
                for: MockContentRepository.self,
                method:
                """
                getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
                """,
                parameterMatchers: matchers
            ))
        }

        func getRelevantsPosts<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, perPage: M2) -> Cuckoo.ProtocolStubThrowingFunction<(Int, Int), [ContentPreviewDTO]> where M1.MatchedType == Int, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: perPage) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(
                for: MockContentRepository.self,
                method:
                """
                getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
                """,
                parameterMatchers: matchers
            ))
        }

        func getPost<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(ownerUsername: M1, slug: M2) -> Cuckoo.ProtocolStubThrowingFunction<(String, String), ContentDTO> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: ownerUsername) { $0.0 }, wrap(matchable: slug) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(
                for: MockContentRepository.self,
                method:
                """
                getPost(ownerUsername: String, slug: String) async throws -> ContentDTO
                """,
                parameterMatchers: matchers
            ))
        }

        func getComments<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(ownerUsername: M1, slug: M2) -> Cuckoo.ProtocolStubThrowingFunction<(String, String), [CommentDTO]> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: ownerUsername) { $0.0 }, wrap(matchable: slug) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(
                for: MockContentRepository.self,
                method:
                """
                getComments(ownerUsername: String, slug: String) async throws -> [CommentDTO]
                """,
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_ContentRepository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        @discardableResult
        func getRecentsPosts<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, perPage: M2) -> Cuckoo.__DoNotUse<(Int, Int), [ContentPreviewDTO]> where M1.MatchedType == Int, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: perPage) { $0.1 }]
            return cuckoo_manager.verify(
                """
                getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }

        @discardableResult
        func getRelevantsPosts<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, perPage: M2) -> Cuckoo.__DoNotUse<(Int, Int), [ContentPreviewDTO]> where M1.MatchedType == Int, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: perPage) { $0.1 }]
            return cuckoo_manager.verify(
                """
                getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }

        @discardableResult
        func getPost<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(ownerUsername: M1, slug: M2) -> Cuckoo.__DoNotUse<(String, String), ContentDTO> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: ownerUsername) { $0.0 }, wrap(matchable: slug) { $0.1 }]
            return cuckoo_manager.verify(
                """
                getPost(ownerUsername: String, slug: String) async throws -> ContentDTO
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }

        @discardableResult
        func getComments<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(ownerUsername: M1, slug: M2) -> Cuckoo.__DoNotUse<(String, String), [CommentDTO]> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: ownerUsername) { $0.0 }, wrap(matchable: slug) { $0.1 }]
            return cuckoo_manager.verify(
                """
                getComments(ownerUsername: String, slug: String) async throws -> [CommentDTO]
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }
    }
}

class ContentRepositoryStub: ContentRepository {
    func getRecentsPosts(page _: Int, perPage _: Int) async throws -> [ContentPreviewDTO] {
        DefaultValueRegistry.defaultValue(for: [ContentPreviewDTO].self)
    }

    func getRelevantsPosts(page _: Int, perPage _: Int) async throws -> [ContentPreviewDTO] {
        DefaultValueRegistry.defaultValue(for: [ContentPreviewDTO].self)
    }

    func getPost(ownerUsername _: String, slug _: String) async throws -> ContentDTO {
        DefaultValueRegistry.defaultValue(for: ContentDTO.self)
    }

    func getComments(ownerUsername _: String, slug _: String) async throws -> [CommentDTO] {
        DefaultValueRegistry.defaultValue(for: [CommentDTO].self)
    }
}

class MockContentDataRepository: ContentDataRepository, Cuckoo.ClassMock {
    typealias MocksType = ContentDataRepository

    typealias Stubbing = __StubbingProxy_ContentDataRepository
    typealias Verification = __VerificationProxy_ContentDataRepository

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    private var __defaultImplStub: ContentDataRepository?

    func enableDefaultImplementation(_ stub: ContentDataRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    override func getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO] {
        await try await cuckoo_manager.callThrows(
            """
            getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
            """,
            parameters: (page, perPage),
            escapingParameters: (page, perPage),
            superclassCall:

            super.getRecentsPosts(page: page, perPage: perPage),

            defaultCall: __defaultImplStub!.getRecentsPosts(page: page, perPage: perPage)
        )
    }

    override func getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO] {
        await try await cuckoo_manager.callThrows(
            """
            getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
            """,
            parameters: (page, perPage),
            escapingParameters: (page, perPage),
            superclassCall:

            super.getRelevantsPosts(page: page, perPage: perPage),

            defaultCall: __defaultImplStub!.getRelevantsPosts(page: page, perPage: perPage)
        )
    }

    override func getPost(ownerUsername: String, slug: String) async throws -> ContentDTO {
        await try await cuckoo_manager.callThrows(
            """
            getPost(ownerUsername: String, slug: String) async throws -> ContentDTO
            """,
            parameters: (ownerUsername, slug),
            escapingParameters: (ownerUsername, slug),
            superclassCall:

            super.getPost(ownerUsername: ownerUsername, slug: slug),

            defaultCall: __defaultImplStub!.getPost(ownerUsername: ownerUsername, slug: slug)
        )
    }

    override func getComments(ownerUsername: String, slug: String) async throws -> [CommentDTO] {
        await try await cuckoo_manager.callThrows(
            """
            getComments(ownerUsername: String, slug: String) async throws -> [CommentDTO]
            """,
            parameters: (ownerUsername, slug),
            escapingParameters: (ownerUsername, slug),
            superclassCall:

            super.getComments(ownerUsername: ownerUsername, slug: slug),

            defaultCall: __defaultImplStub!.getComments(ownerUsername: ownerUsername, slug: slug)
        )
    }

    struct __StubbingProxy_ContentDataRepository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }

        func getRecentsPosts<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, perPage: M2) -> Cuckoo.ClassStubThrowingFunction<(Int, Int), [ContentPreviewDTO]> where M1.MatchedType == Int, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: perPage) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(
                for: MockContentDataRepository.self,
                method:
                """
                getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
                """,
                parameterMatchers: matchers
            ))
        }

        func getRelevantsPosts<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, perPage: M2) -> Cuckoo.ClassStubThrowingFunction<(Int, Int), [ContentPreviewDTO]> where M1.MatchedType == Int, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: perPage) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(
                for: MockContentDataRepository.self,
                method:
                """
                getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
                """,
                parameterMatchers: matchers
            ))
        }

        func getPost<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(ownerUsername: M1, slug: M2) -> Cuckoo.ClassStubThrowingFunction<(String, String), ContentDTO> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: ownerUsername) { $0.0 }, wrap(matchable: slug) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(
                for: MockContentDataRepository.self,
                method:
                """
                getPost(ownerUsername: String, slug: String) async throws -> ContentDTO
                """,
                parameterMatchers: matchers
            ))
        }

        func getComments<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(ownerUsername: M1, slug: M2) -> Cuckoo.ClassStubThrowingFunction<(String, String), [CommentDTO]> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: ownerUsername) { $0.0 }, wrap(matchable: slug) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(
                for: MockContentDataRepository.self,
                method:
                """
                getComments(ownerUsername: String, slug: String) async throws -> [CommentDTO]
                """,
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_ContentDataRepository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        @discardableResult
        func getRecentsPosts<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, perPage: M2) -> Cuckoo.__DoNotUse<(Int, Int), [ContentPreviewDTO]> where M1.MatchedType == Int, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: perPage) { $0.1 }]
            return cuckoo_manager.verify(
                """
                getRecentsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }

        @discardableResult
        func getRelevantsPosts<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, perPage: M2) -> Cuckoo.__DoNotUse<(Int, Int), [ContentPreviewDTO]> where M1.MatchedType == Int, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: perPage) { $0.1 }]
            return cuckoo_manager.verify(
                """
                getRelevantsPosts(page: Int, perPage: Int) async throws -> [ContentPreviewDTO]
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }

        @discardableResult
        func getPost<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(ownerUsername: M1, slug: M2) -> Cuckoo.__DoNotUse<(String, String), ContentDTO> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: ownerUsername) { $0.0 }, wrap(matchable: slug) { $0.1 }]
            return cuckoo_manager.verify(
                """
                getPost(ownerUsername: String, slug: String) async throws -> ContentDTO
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }

        @discardableResult
        func getComments<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(ownerUsername: M1, slug: M2) -> Cuckoo.__DoNotUse<(String, String), [CommentDTO]> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: ownerUsername) { $0.0 }, wrap(matchable: slug) { $0.1 }]
            return cuckoo_manager.verify(
                """
                getComments(ownerUsername: String, slug: String) async throws -> [CommentDTO]
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }
    }
}

class ContentDataRepositoryStub: ContentDataRepository {
    override func getRecentsPosts(page _: Int, perPage _: Int) async throws -> [ContentPreviewDTO] {
        DefaultValueRegistry.defaultValue(for: [ContentPreviewDTO].self)
    }

    override func getRelevantsPosts(page _: Int, perPage _: Int) async throws -> [ContentPreviewDTO] {
        DefaultValueRegistry.defaultValue(for: [ContentPreviewDTO].self)
    }

    override func getPost(ownerUsername _: String, slug _: String) async throws -> ContentDTO {
        DefaultValueRegistry.defaultValue(for: ContentDTO.self)
    }

    override func getComments(ownerUsername _: String, slug _: String) async throws -> [CommentDTO] {
        DefaultValueRegistry.defaultValue(for: [CommentDTO].self)
    }
}
