import XCTest
import Presentation
import Domain
import Combine

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

class ProblemDetailViewModel_Test: BaseTestCase {
    var viewModel: MockProblemDetailViewModel!
    
    /*
    <테스트 설명> 키워드와 띄어쓰기 기준으로 잘 분리되는지 테스트
    <가정> 문장: "aaabbb aaa bbb", 키워드: "aaa"
    <원하는 결과값> answerSplitedForTest == ["aaa", "bbb", "aaa", "bbb"]
     */
    func testSplittingSentence() throws {
        given {
            viewModel = MockProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.getProblemDetailForTest()
            viewModel.splitSentenceForTest()
        }
        then {
            XCTAssertEqual(viewModel.answerSplitedForTest, ["CPU가", "이전", "상태의", "프로세스를", "PCB", "에", "보관하고,", "또", "다른", "프로세스를", "PCB", "에서", "읽어", "레지스터에", "적재하는", "과정"])
        }
    }
    
    /*
     <테스트 설명> 글자 수 일치하는 키워드 입력하면 이를 맞게 감지하는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "AAA"
     <원하는 결과값> isWrongInput == false
     */
    func testJudgingSameLengthKeyword() throws {
        given {
            viewModel = MockProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.inputForTest = "AAA"
        }
        when {
            viewModel.getProblemDetailForTest()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.isWrongInputForTest, false)
        }
    }
    
    /*
     <테스트 설명> 글자 수 불일치하는 키워드 입력하면 이를 틀리게 감지하는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "AAAAA"
     <원하는 결과값> isWrongInput == true
     */
    func testJudgingNotSameLengthKeyword() throws {
        given {
            viewModel = MockProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.inputForTest = "AAAAA"
        }
        when {
            viewModel.getProblemDetailForTest()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.isWrongInputForTest, true)
        }
    }
    
    /*
     <테스트 설명> 맞는 키워드를 입력하면 정답 상태로 넘어가는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "PCB"
     <원하는 결과값> solvingState == .correctKeyword
     */
    func testJudgingCorrectKeyword() throws {
        given {
            viewModel = MockProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.inputForTest = "PCB"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.solvingStateForTest, .correctKeyword)
        }
    }
    
    /*
     <테스트 설명> 틀린 키워드를 입력하면 오답 상태로 넘어가는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "WrongInput"
     <원하는 결과값> solvingState == .wrongKeyword
     */
    func testJudgingWrongKeyword() throws {
        given {
            viewModel = MockProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.inputForTest = "AAA"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.solvingStateForTest, .wrongKeyword)
        }
    }
    
    /*
     <테스트 설명> 오답 상태에서 일정 시간 후에 초기화 상태로 넘어가는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "AAA", 2초 이상 지난 후 상태 확인
     <원하는 결과값> solvingState == .initial
     */
    func testChangingStateFromWrongState() throws {
        
        let expectation = XCTestExpectation(description: "ChangingStateFromWrongState")
        
        given {
            viewModel = MockProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.inputForTest = "AAA"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
            DispatchQueue.main.asyncAfter(deadline: .now()+viewModel.stateChangingTimeForTest) {
                expectation.fulfill()
            }
        }
        then {
            wait(for: [expectation], timeout: viewModel.stateChangingTimeForTest)
            XCTAssertEqual(viewModel.solvingStateForTest, .initial)
        }
    }
    
    /*
     <테스트 설명> 정답 상태에서 일정 시간 후에 정답 보여주기 상태로 넘어가는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "PCB", 2초 이상 지난 후 상태 확인
     <원하는 결과값> solvingState == .showAnswer
     */
    func testChangingStateFromCorrectState() throws {
        
        let expectation = XCTestExpectation(description: "ChangingStateFromCorrectState")
        
        given {
            viewModel = MockProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.inputForTest = "PCB"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
            DispatchQueue.main.asyncAfter(deadline: .now()+viewModel.stateChangingTimeForTest) {
                expectation.fulfill()
            }
        }
        then {
            wait(for: [expectation], timeout: viewModel.stateChangingTimeForTest)
            XCTAssertEqual(viewModel.solvingStateForTest, .showAnswer)
        }
    }
}
