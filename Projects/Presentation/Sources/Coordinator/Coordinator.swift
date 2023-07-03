//
//  Coordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

enum Page: Hashable {
    case learningHomeView
    case prevProblemCategoryView
    case myPageView
}

@available(iOS 16.0, *)
class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ page: ExamplePage) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .learningHomeView:
            LearningHomeView(viewModel: LearningHomeViewModel())
        case .prevProblemCategoryView:
            PrevProblemView(viewModel: PrevProblemViewModel())
        case .myPageView:
            MyPageView(viewModel: MyPageViewModel())
        }
    }
}
