//
//  LearningCategoryViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public class LearningCategoryViewModel: ObservableObject {
    private var coordinator: CoordinatorProtocol
    
    public init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func back() {
        coordinator.pop()
    }
}
