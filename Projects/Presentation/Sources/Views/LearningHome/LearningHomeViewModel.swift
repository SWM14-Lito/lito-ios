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
    @Published private(set) var isGotRequest: Bool = false
    @Published var solvingProblem: ProblemCellVO?
    @Published var userInfo: LearningHomeUserInfoVO?
    
    public init(useCase: LearningHomeUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
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
        coordinator.push(.solvingProblemListScene)
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
                self.isGotRequest = true
            }
            .store(in: cancelBag)
    }
}
extension LearningHomeViewModel: ProblemCellHandling {
    // 해당 문제 풀이 화면으로 이동하기
    public func moveToProblemView(id: Int) {
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
