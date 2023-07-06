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
        container.register(ExampleViewModel.self) { resolver in
            let useCase = resolver.resolve(ExampleUseCase.self)!
            return ExampleViewModel(exampleUseCase: useCase)
        }
        container.register(ExampleView.self) { resolver in
            let viewModel = resolver.resolve(ExampleViewModel.self)!
            return ExampleView(viewModel: viewModel)
        }
        container.register(LoginViewModel.self) { resolver in
            let useCase = resolver.resolve(LoginUseCase.self)!
            return LoginViewModel(coordinator: coordinator, useCase: useCase)
        }
        container.register(LoginView.self) { resolver in
            let viewModel = resolver.resolve(LoginViewModel.self)!
            return LoginView(viewModel: viewModel)
        }
        
        container.register(ProfileSettingViewModel.self) { _ in
            return ProfileSettingViewModel(coordinator: coordinator)
        }
        
        container.register(ProfileSettingView.self) { resolver in
            let viewModel = resolver.resolve(ProfileSettingViewModel.self)!
            return ProfileSettingView(viewModel: viewModel)
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
        
        container.register(RootTabView.self) { resolver in
            let tab1 = resolver.resolve(LearningHomeView.self)!
            let tab2 = resolver.resolve(PrevProblemCategoryView.self)!
            let tab3 = resolver.resolve(MyPageView.self)!
            return RootTabView(tab1: tab1, tab2: tab2, tab3: tab3)
        }
        
    }
    
}
