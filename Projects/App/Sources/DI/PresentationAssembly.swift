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
    
    let coordinator: Coordinator
    
    public func assemble(container: Container) {
        container.register(HomeViewModel.self) { resolver in
            let useCase = resolver.resolve(HomeUseCase.self)!
            return HomeViewModel(homeUseCase: useCase)
        }
        container.register(HomeView.self) { resolver in
            let homeViewModel = resolver.resolve(HomeViewModel.self)!
            return HomeView(viewModel: homeViewModel)
        }
        container.register(LoginViewModel.self) { resolver in
            let useCase = resolver.resolve(LoginUseCase.self)!
            return LoginViewModel(useCase: useCase)
        }
        
        container.register(LearningHomeViewModel.self) { _ in
            return LearningHomeViewModel(coordinator: coordinator)
        
        }
        container.register(LearningHomeView.self) { resolver in
            let viewModel = resolver.resolve(LearningHomeViewModel.self)!
            return LearningHomeView(viewModel: viewModel)
        }
        
        container.register(LearningCategoryViewModel.self) { _ in
            return LearningCategoryViewModel(coordinator: coordinator)
        }
        container.register(LearningCategoryView.self) { resolver in
            let viewModel = resolver.resolve(LearningCategoryViewModel.self)!
            return LearningCategoryView(viewModel: viewModel)
        }
        
        container.register(PrevProblemCategoryViewModel.self) { _ in
            return PrevProblemCategoryViewModel(coordinator: coordinator)
        }
        container.register(PrevProblemCategoryView.self) { resolver in
            let viewModel = resolver.resolve(PrevProblemCategoryViewModel.self)!
            return PrevProblemCategoryView(viewModel: viewModel)
        }
    
        container.register(MyPageViewModel.self) { _ in
            return MyPageViewModel(coordinator: coordinator)
        }
        container.register(MyPageView.self) { resolver in
            let viewModel = resolver.resolve(MyPageViewModel.self)!
            return MyPageView(viewModel: viewModel)
        }
    }
    
}
