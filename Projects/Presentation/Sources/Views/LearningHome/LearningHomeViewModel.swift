//
//  LearningHomeViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain
import Combine

public final class LearningHomeViewModel: BaseViewModel {
    private let useCase: LearningHomeUseCase
    private(set) var isViewFirstAppeared: Bool = false
    private var selectedProblemId: Int = 0
    @Published private(set) var isGotResponse: Bool = false
    @Published var solvingProblem: DefaultProblemCellVO?
    @Published var userInfo: LearningHomeUserInfoVO?
    @Published var learningRate: Float = 0.8 // 임시 변수
    
    public init(useCase: LearningHomeUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    // 서버에서 전체 데이터 다운만 하기 위해 판별해주는 역할
    func setViewFirstAppeared() {
        isViewFirstAppeared = true
    }
    
    // 학습 화면으로 이동하기
    func moveToLearningView() {
        coordinator.push(.problemListScene)
    }
    
    // 찜한 목록 화면으로 이동하기
    func moveToFavoriteProblemView() {
        coordinator.push(.favoriteProblemListScene)
    }
    
    // 풀던 문제 화면으로 이동하기
    func moveToSolvingProblemView() {
        coordinator.push(.solvingProblemListScene)
    }
    
    // 알림 목록 화면으로 이동하기
    func moveToNotiView() {
        print("알림 목록으로 이동하기")
    }

    // 프로필 정보와 문제 정보 가져오기
    func getProfileAndProblems() {
        useCase.getProfileAndProblems()
            .sinkToResult { result in
                switch result {
                case .success(let learningHomeVO):
                    self.solvingProblem = learningHomeVO.solvingProblem
                    self.userInfo = learningHomeVO.userInfo
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
                self.isGotResponse = true
            }
            .store(in: cancelBag)
    }
    
    // 문제 풀이 화면으로 이동했다가 다시 돌아왔을 때 변할 가능성 있는 값 다시 받아오기
    func getProblemMutable() {
        if selectedProblemId == 0 {
            return
        }
        useCase.getProblemMutable(id: selectedProblemId)
            .sinkToResult { result in
                switch result {
                case .success(let problemMutableVO):
                    self.solvingProblem?.favorite = problemMutableVO.favorite
                    self.solvingProblem?.problemStatus = problemMutableVO.problemStatus
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
                self.selectedProblemId = 0
            }
            .store(in: cancelBag)
    }
}
extension LearningHomeViewModel: ProblemCellHandling {
    // 해당 문제 풀이 화면으로 이동하기
    public func moveToProblemView(id: Int) {
        selectedProblemId = id
        coordinator.push(.problemDetailScene(id: id))
    }
    
    // 찜하기 or 찜해제하기
    public func changeFavoriteStatus(id: Int) {
        useCase.toggleProblemFavorite(id: id)
            .sinkToResult { result in
                switch result {
                case .success(_):
                    self.solvingProblem?.favorite.toggle()
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
            }
            .store(in: cancelBag)
    }
}
