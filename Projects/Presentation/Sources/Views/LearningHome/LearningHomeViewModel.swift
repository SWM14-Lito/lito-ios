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
    
    public init(useCase: LearningHomeUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    func moveToLearningCategoryView() {
        coordinator.push(.learningCategoryView)
    }
}
