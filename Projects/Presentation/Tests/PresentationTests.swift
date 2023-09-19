import XCTest
@testable import Presentation
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
    var viewModel: ProblemDetailViewModel!
    
    /*
    <테스트 설명> 키워드와 띄어쓰기 기준으로 잘 분리되는지 테스트
    <가정> 문장: "aaabbb aaa bbb", 키워드: "aaa"
    <원하는 결과값> answerSplitedForTest == ["aaa", "bbb", "aaa", "bbb"]
     */
    func testSplittingSentence() throws {
        given {
            viewModel = ProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.answerSplited, ["CPU가", "이전", "상태의", "프로세스를", "PCB", "에", "보관하고,", "또", "다른", "프로세스를", "PCB", "에서", "읽어", "레지스터에", "적재하는", "과정"])
        }
    }
    
    /*
     <테스트 설명> 글자 수 일치하는 키워드 입력하면 이를 맞게 감지하는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "AAA"
     <원하는 결과값> isWrongInput == false
     */
    func testJudgingSameLengthKeyword() throws {
        given {
            viewModel = ProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.input = "AAA"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.isWrongInput, false)
        }
    }
    
    /*
     <테스트 설명> 글자 수 불일치하는 키워드 입력하면 이를 틀리게 감지하는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "AAAAA"
     <원하는 결과값> isWrongInput == true
     */
    func testJudgingNotSameLengthKeyword() throws {
        given {
            viewModel = ProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.input = "AAAAA"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.isWrongInput, true)
        }
    }
    
    /*
     <테스트 설명> 맞는 키워드를 입력하면 정답 상태로 넘어가는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "PCB"
     <원하는 결과값> solvingState == .correctKeyword
     */
    func testJudgingCorrectKeyword() throws {
        given {
            viewModel = ProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.input = "PCB"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.solvingState, .correctKeyword)
        }
    }
    
    /*
     <테스트 설명> 틀린 키워드를 입력하면 오답 상태로 넘어가는지 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "WrongInput"
     <원하는 결과값> solvingState == .wrongKeyword
     */
    func testJudgingWrongKeyword() throws {
        given {
            viewModel = ProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.input = "AAA"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
        }
        then {
            XCTAssertEqual(viewModel.solvingState, .wrongKeyword)
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
            viewModel = ProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.input = "AAA"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
            DispatchQueue.main.asyncAfter(deadline: .now()+viewModel.stateChangingTime) {
                expectation.fulfill()
            }
        }
        then {
            wait(for: [expectation], timeout: viewModel.stateChangingTime)
            XCTAssertEqual(viewModel.solvingState, .initial)
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
            viewModel = ProblemDetailViewModel(
                problemId: 0,
                useCase: MockProblemDetailUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.input = "PCB"
        }
        when {
            viewModel.onScreenAppeared()
            viewModel.onAnswerSubmitted()
            DispatchQueue.main.asyncAfter(deadline: .now()+viewModel.stateChangingTime) {
                expectation.fulfill()
            }
        }
        then {
            wait(for: [expectation], timeout: viewModel.stateChangingTime)
            XCTAssertEqual(viewModel.solvingState, .showAnswer)
        }
    }
    
    /*
     <테스트 설명> ProblemDetailVO 가져오는 것에 실패하면 테스트
     <가정> 실제 정답: "PCB", 입력 키워드: "PCB", 2초 이상 지난 후 상태 확인
     <원하는 결과값> solvingState == .showAnswer
     */
    func testGettingProblemDetailVOFail() throws {
        given {
            let useCase = MockProblemDetailUseCase()
            useCase.setGetProblemDetailResponse { _ in
                return Fail<ProblemDetailVO, Error>(error: ErrorVO.retryableError("에러 테스트"))
                    .eraseToAnyPublisher()
            }
            viewModel = ProblemDetailViewModel(
                problemId: 0,
                useCase: useCase,
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
            viewModel.input = "PCB"
        }
        when {
            viewModel.onScreenAppeared()
        }
        then {
            XCTAssertEqual(viewModel.errorMessageForAlert, "에러 테스트")
        }
    }
}
