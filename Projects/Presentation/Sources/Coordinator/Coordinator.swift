//
//  Coordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

enum Page: Hashable {
    case learningHomeView, learningCategoryView
    case prevProblemCategoryView
    case myPageView
}

@available(iOS 16.0, *)
public class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    public init() { }
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    // view는 viewModel에 의존 (로직 처리하기 위함)
    // viewModel은 coordinator에 의존 (화면 전환하기 위함)
    // coordinator는 view에 의존 (전환할 화면 가지고 있음)
    // 의존 관계가 순환되는게 과연 맞는가? -> 맞다면 coordinator를 self로 해도 되는가?
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .learningHomeView:
            LearningHomeView(viewModel: LearningHomeViewModel(coordinator: self))
        case .learningCategoryView:
            LearningCategoryView(viewModel: LearningCategoryViewModel(coordinator: self))
        case .prevProblemCategoryView:
            PrevProblemCategoryView(viewModel: PrevProblemCategoryViewModel(coordinator: self))
        case .myPageView:
            MyPageView(viewModel: MyPageViewModel(coordinator: self))
        }
    }
}
