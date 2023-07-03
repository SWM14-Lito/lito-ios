//
//  PresentationAssembly.swift
//  App
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Swinject
import Domain
import Presentation

public struct PresentationAssembly: Assembly {
    
    public func assemble(container: Container) {
        container.register(HomeViewModel.self) { resolver in
            let useCase = resolver.resolve(HomeUseCase.self)!
            return HomeViewModel(homeUseCase: useCase)
        }
        
        container.register(HomeView.self) { resolver in
            let homeViewModel = resolver.resolve(HomeViewModel.self)!
            return HomeView(viewModel: homeViewModel)
        }
        
        container.register(LearningHomeView.self) { _ in
            return LearningHomeView(viewModel: LearningHomeViewModel(coordinator: Coordinator.instance))
        }

        container.register(LearningCategoryView.self) { _ in
            return LearningCategoryView(viewModel: LearningCategoryViewModel(coordinator: Coordinator.instance))
        }
        
        container.register(PrevProblemCategoryView.self) { _ in
            return PrevProblemCategoryView(viewModel: PrevProblemCategoryViewModel(coordinator: Coordinator.instance))
        }

        container.register(MyPageView.self) { _ in
            return MyPageView(viewModel: MyPageViewModel(coordinator: Coordinator.instance))
        }
    }
    
}
