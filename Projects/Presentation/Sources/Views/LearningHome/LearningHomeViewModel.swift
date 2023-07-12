//
//  LearningHomeViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain

public final class LearningHomeViewModel: BaseViewModel, ObservableObject {
    
    private let useCase: LearningHomeUseCase
    @Published var imageData: Data?
    @Published var nickname: String?
    @Published var solvingProblem: ProblemVO?
    @Published var recommendedProblems: [ProblemVO?] = [ProblemVO?]()
    
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

    // 서버에서 가져오는 작업
    // 프로필 이미지, 닉네임, 풀던 문제, 추천 문제 받아오기
}
