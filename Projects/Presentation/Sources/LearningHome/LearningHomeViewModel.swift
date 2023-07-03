//
//  LearningHomeViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public class LearningHomeViewModel: ObservableObject {
    private var coordinator: any CoordinatorProtocol
    
    public init(coordinator: any CoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func moveToLearningCategoryView() {
        coordinator.push(.learningCategoryView)
    }
}
