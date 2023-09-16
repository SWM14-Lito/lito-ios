import XCTest
import Presentation
import Domain

class BaseTestCase: XCTestCase {
    func given(_ task: () -> Void) {
        task()
    }
    func when(_ task: () -> Void) {
        task()
    }
    func then(_ task: () -> Void) {
        task()
    }
}

class PresentationTests: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testExample() throws {
        XCTAssertTrue(true)
    }
}

// 단어 잘 쪼개는지 판별
class ProblemDetailSentenceSplitTest: BaseTestCase {
    
    var viewModel: ProblemDetailViewModel!
    
    func testSentenceSplit() throws {
        given {
            viewModel = ProblemDetailViewModel(problemId: 0, useCase: MockProblemDetailUseCase(), coordinator: MockCoordinator(), toastHelper: MockToastHelper())
        }
        when {
            viewModel.onScreenAppeared()
        }
        then {
            XCTAssertEqual(viewModel.answerSplited, ["aaa", "bbb", "aaa", "bbb"])
        }
    }
}

// 키워드 정답 여부 판별

// 특정 조건으로 상태값이 변하는지 판별
