//
//  AppCoordinator.swift
//  App
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Presentation

public class Coordinator: ObservableObject, CoordinatorProtocol {
    @Published public var path = NavigationPath()
    public var pathPublisher: Published<NavigationPath>.Publisher { $path }
    
    public init() { }
    
    public func push(_ page: Page) {
        path.append(page)
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    // view는 viewModel에 의존 (로직 처리하기 위함)
    // viewModel은 coordinator에 의존 (화면 전환하기 위함)
    // coordinator는 view에 의존 (전환할 화면 가지고 있음)
    // 의존 관계가 순환되는게 과연 맞는가? -> 맞다면 coordinator를 self로 해도 되는가?
//    @ViewBuilder
//    public func build(page: Page) -> some View {
//        switch page {
//        case .learningHomeView:
//            LearningHomeView(viewModel: LearningHomeViewModel(coordinator: self))
//        case .learningCategoryView:
//            LearningCategoryView(viewModel: LearningCategoryViewModel(coordinator: self))
//        case .prevProblemCategoryView:
//            PrevProblemCategoryView(viewModel: PrevProblemCategoryViewModel(coordinator: self))
//        case .myPageView:
//            MyPageView(viewModel: MyPageViewModel(coordinator: self))
//        }
//    }
}
