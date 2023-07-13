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

public final class LearningHomeViewModel: BaseViewModel, ObservableObject {
    
    private let cancelBag = CancelBag()
    private let useCase: LearningHomeUseCase
    @Published var learningHomeVO: LearningHomeVO?
    @Published private(set) var errorObject = ErrorObject()
    
    
    public init(useCase: LearningHomeUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    // 학습 화면으로 이동하기
    func moveToLearningView() {
        coordinator.push(.learningCategoryView)
    }
    
    // 찜한 목록 화면으로 이동하기
    func moveToLikedProblemView() {
        print("찜한 목록 화면으로 이동")
    }

    func getProfileAndProblems() {
        useCase.getProfileAndProblems()
            .sinkToResult { result in
                switch result {
                case .success(let learningHomeVO):
                    self.learningHomeVO = learningHomeVO
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
            }
            .store(in: cancelBag)
    }
}
