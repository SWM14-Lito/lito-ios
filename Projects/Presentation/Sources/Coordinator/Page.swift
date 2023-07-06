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
    public func getView(viewResolver: ViewResolverProtocol) -> some View {
        switch self {
        case .learningHomeView:
            viewResolver.resolveView(LearningHomeView.self)
        case .learningCategoryView:
            viewResolver.resolveView(LearningCategoryView.self)
        case .prevProblemCategoryView:
            viewResolver.resolveView(PrevProblemCategoryView.self)
        case .myPageView:
            viewResolver.resolveView(MyPageView.self)
        }
    }
}
