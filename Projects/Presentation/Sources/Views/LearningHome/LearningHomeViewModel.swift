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
    @Published private(set) var isLoading: Bool = false
    @Published var solvingProblem: DefaultProblemCellVO?
    @Published var recommendedProblem: [DefaultProblemCellVO]? // 임시 변수 (서버 통신 필요)
    @Published var userInfo: LearningHomeUserInfoVO?
    @Published var learningRate: Float = 0.8 // 임시 변수 (서버 통신 필요)
    @Published var goalCount: Int = 5 // 임시 변수 (서버 통신 필요)
    
    public init(useCase: LearningHomeUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
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
        isLoading = true
        useCase.getProfileAndProblems()
            .sinkToResult { result in
                switch result {
                case .success(let learningHomeVO):
                    self.solvingProblem = learningHomeVO.solvingProblem
                    self.recommendedProblem = nil
                    self.userInfo = learningHomeVO.userInfo
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
                self.isLoading = false
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
