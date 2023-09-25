//
//  ProblemListViewModelTest.swift
//  PresentationTests
//
//  Created by Lee Myeonghwan on 2023/09/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

import XCTest
import Combine
@testable import Presentation
@testable import Domain

class ProblemListViewModelTest: BaseTestCase {
    var viewModel: ProblemListViewModel!
    
    /*
    <테스트 설명> 문제 리스트를 가져와서 problemCellList 에 잘 저장하는지 테스트
    <가정> 문제 10개를 가져온다고 가졍
    <원하는 결과값> problemCellList.count == 10
     */
    func testOnProblemListAppeared() throws {
        given {
            viewModel = ProblemListViewModel(
                useCase: MockProblemListUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.onProblemListAppeared()
        }
        then {
            XCTAssertEqual(viewModel.problemCellList.count, 10)
        }
    }
    
    /*
    <테스트 설명> 문제 리스트를 스크롤하여 다음 problemCellList 를 잘 불러오는지 테스트
    <가정> 문제 10 개를 더 가져온다고 가졍
    <원하는 결과값> problemCellList.count == 20
     */
    func testOnProblemCellAppeared() throws {
        given {
            viewModel = ProblemListViewModel(
                useCase: MockProblemListUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.onProblemListAppeared()
            viewModel.onProblemCellAppeared(id: 9)
        }
        then {
            XCTAssertEqual(viewModel.problemCellList.count, 20)
        }
    }
    
    /*
    <테스트 설명> 문제 리스트를 스크롤하고, 총 문제 개수에 도달하면 더 이상 문제 리스트를 불러 오지 않는지 테스트
    <가정> 총 문제 개수가 20 개라고 가정
    <원하는 결과값> problemCellList.count == 20
     */
    func testOnProblemCellAppeared_ReachLimit() throws {
        given {
            viewModel = ProblemListViewModel(
                useCase: MockProblemListUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.onProblemListAppeared()
            viewModel.onProblemCellAppeared(id: 9)
            viewModel.onProblemCellAppeared(id: 19)
        }
        then {
            XCTAssertEqual(viewModel.problemCellList.count, 20)
        }
    }
    
    /*
    <테스트 설명> 화면 이동이 발생했을떄, 문제 리스트가 제대로 업데이트 되는지 테스트
    <가정> 교체되는 문제의 첫번째 id 가 10이라고 가정.
    <원하는 결과값> problemCellList.count == 10, problemCellList[0].id == 10
     */
    func testonScreenAppeared() throws {
        let useCase = MockProblemListUseCase()
        given {
            viewModel = ProblemListViewModel(
                useCase: useCase,
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.onProblemListAppeared()
            useCase.setGetProblemListResponse(
                {
                    let problemListVO = ProblemListVO.makeMock(start: 10, end: 19, total: 20)
                    return Just(problemListVO)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }()
            )
            viewModel.onScreenAppeared()
        }
        then {
            XCTAssertEqual(viewModel.problemCellList.count, 10)
            XCTAssertEqual(viewModel.problemCellList[0].problemId, 10)
        }
    }
    
    /*
    <테스트 설명> 문제 리스트를 가져온 후, 필터를 바꿨을 떄 초기화 후 다시 문제를 가져오는지 테스트
    <가정> 문제 10 개를 가져온다고 가정.
    <원하는 결과값> problemCellList.count == 10
     */
    func testOnFilterChanged() throws {
        given {
            viewModel = ProblemListViewModel(
                useCase: MockProblemListUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.onProblemListAppeared()
            viewModel.onFilterChanged()
        }
        then {
            XCTAssertEqual(viewModel.problemCellList.count, 10)
        }
    }
    
}
