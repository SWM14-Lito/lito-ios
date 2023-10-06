//
//  LearningHomeViewModelTest.swift
//  PresentationTests
//
//  Created by Lee Myeonghwan on 2023/09/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import XCTest
import Combine
@testable import Presentation
@testable import Domain

class LearningHomeViewModelTest: BaseTestCase {
    var viewModel: LearningHomeViewModel!
    
    /*
    <테스트 설명> 프로필 문제와 정보를 잘 가져와서 저장하는지 테스트
    <가정> learningHomeVO, processProblem, recommendProblems 모두 존재
    <원하는 결과값> learningHomeVO == LearningHomeVO.mock, processProblem == LearningHomeVO.mock.processProblem, recommendProblems == LearrningHomeVO.mock.recommendProblems
     */
    func testOnProblemListAppeared() throws {
        given {
            viewModel = LearningHomeViewModel(
                useCase: MockLearningHomeUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.onScreenAppeared()
        }
        then {
            XCTAssertEqual(viewModel.learningHomeVO, LearningHomeVO.mock)
            XCTAssertEqual(viewModel.processProblem, LearningHomeVO.mock.processProblem)
            XCTAssertEqual(viewModel.recommendProblems, LearningHomeVO.mock.recommendProblems)
        }
    }
    
    /*
    <테스트 설명> Scene 이동 테스트
    <가정> onStartLearningButtonClicked, onFavoriteListButtonClicked, onSolvingListButtonClicked, onProblemCellClicked
    <원하는 결과값> 각각의 메소드에 맞는 Scene
     */
    func testMoveScenes() throws {
        let mockCoordinator = MockCoordinator()
        given {
            viewModel = LearningHomeViewModel(
                useCase: MockLearningHomeUseCase(),
                coordinator: mockCoordinator,
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.onStartLearningButtonClicked()
            viewModel.onFavoriteListButtonClicked()
            viewModel.onSolvingListButtonClicked()
            viewModel.onProblemCellClicked(id: 0)
        }
        then {
            XCTAssertEqual(mockCoordinator.movedScene, [.problemListScene, .favoriteProblemListScene, .solvingProblemListScene, .problemDetailScene(id: 0)])
        }
    }
}

public final class MockLearningHomeUseCase: LearningHomeUseCase {
    
    private var getProfileAndProblemsResponse: AnyPublisher<LearningHomeVO, Error> = {
        return Just(LearningHomeVO.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }()

    private var toggleProblemFavoriteResponse: AnyPublisher<Void, Error> =
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    
    public init() {}

    public func getProfileAndProblemsResponse(_ response: AnyPublisher<LearningHomeVO, Error>) {
        self.getProfileAndProblemsResponse = response
    }

    public func setToggleProblemFavoriteResponse(_ response: AnyPublisher<Void, Error>) {
        self.toggleProblemFavoriteResponse = response
    }
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error> {
        getProfileAndProblemsResponse
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        toggleProblemFavoriteResponse
    }
    
}
