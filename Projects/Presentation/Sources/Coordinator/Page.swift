//
//  Coordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public enum Page: Hashable {
    case learningHomeView, learningCategoryView
    case prevProblemCategoryView
    case myPageView
    
    @ViewBuilder
    func getView(coordinator: any CoordinatorProtocol) -> some View {
        switch self {
        case .learningHomeView:
            LearningHomeView(viewModel: LearningHomeViewModel(coordinator: coordinator))
        case .learningCategoryView:
            LearningCategoryView(viewModel: LearningCategoryViewModel(coordinator: coordinator))
        case .prevProblemCategoryView:
            PrevProblemCategoryView(viewModel: PrevProblemCategoryViewModel(coordinator: coordinator))
        case .myPageView:
            MyPageView(viewModel: MyPageViewModel(coordinator: coordinator))
        }
    }
}
