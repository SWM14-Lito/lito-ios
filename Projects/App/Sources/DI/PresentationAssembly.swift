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
        // ------------------------ Common ------------------------
        // Example
        container.register(ExampleViewModel.self) { resolver in
            let useCase = resolver.resolve(ExampleUseCase.self)!
            return ExampleViewModel(exampleUseCase: useCase)
        }
        container.register(ExampleView.self) { resolver in
            let viewModel = resolver.resolve(ExampleViewModel.self)!
            return ExampleView(viewModel: viewModel)
        }
        // Login
        container.register(LoginViewModel.self) { resolver in
            let useCase = resolver.resolve(LoginUseCase.self)!
            return LoginViewModel(coordinator: coordinator, useCase: useCase)
        }
        container.register(LoginView.self) { resolver in
            let viewModel = resolver.resolve(LoginViewModel.self)!
            return LoginView(viewModel: viewModel)
        }
        // ProfileSetting
        container.register(ProfileSettingViewModel.self) { resolver in
            let useCase = resolver.resolve(ProfileSettingUseCase.self)!
            return ProfileSettingViewModel(useCase: useCase, coordinator: coordinator)
        }
        
        container.register(ProfileSettingView.self) { resolver in
            let viewModel = resolver.resolve(ProfileSettingViewModel.self)!
            return ProfileSettingView(viewModel: viewModel)
        }
        // RootTab
        container.register(RootTabView.self) { resolver in
            let tab1 = resolver.resolve(LearningHomeView.self)!
            let tab2 = resolver.resolve(PedigreeListView.self)!
            let tab3 = resolver.resolve(MyPageView.self)!
            let tab1ViewModel = resolver.resolve(LearningHomeViewModel.self)!
            return RootTabView(tab1: tab1, tab2: tab2, tab3: tab3, tab1ViewModel: tab1ViewModel)
        }
        // ImageHelper
        container.register(ImageHelper.self) { _ in
            return DefaultImageHelper()
        }
        // ------------------------ First Tab ------------------------
        // LearningHome
        container.register(LearningHomeViewModel.self) { resolver in
            let useCase = resolver.resolve(LearningHomeUseCase.self)!
            return LearningHomeViewModel(useCase: useCase, coordinator: coordinator)
        }
        container.register(LearningHomeView.self) { resolver in
            let viewModel = resolver.resolve(LearningHomeViewModel.self)!
            return LearningHomeView(viewModel: viewModel)
        }
        // ProblemList
        container.register(ProblemListViewModel.self) { resolver in
            let useCase = resolver.resolve(ProblemListUseCase.self)!
            return ProblemListViewModel(useCase: useCase, coordinator: coordinator)
        }
        
        container.register(ProblemListView.self) { resolver in
            let viewModel = resolver.resolve(ProblemListViewModel.self)!
            return ProblemListView(viewModel: viewModel)
        }
        // ProblemSolving
        container.register(ProblemSolvingViewModel.self) { (resolver, id: Int) in
            let useCase = resolver.resolve(ProblemSolvingUseCase.self)!
            return ProblemSolvingViewModel(problemId: id, useCase: useCase, coordinator: coordinator)
        }
        
        container.register(ProblemSolvingView.self) { (resolver, id: Int) in
            let viewModel = resolver.resolve(ProblemSolvingViewModel.self, argument: id)!
            return ProblemSolvingView(viewModel: viewModel)
        }
        // ------------------------ Second Tab ------------------------
        // PedigreeList
        container.register(PedigreeListViewModel.self) { _ in
            return PedigreeListViewModel(coordinator: coordinator)
        }
        container.register(PedigreeListView.self) { resolver in
            let viewModel = resolver.resolve(PedigreeListViewModel.self)!
            return PedigreeListView(viewModel: viewModel)
        }
        // ------------------------ Third Tab ------------------------
        // MyPage
        container.register(MyPageViewModel.self) { _ in
            return MyPageViewModel(coordinator: coordinator)
        }
        container.register(MyPageView.self) { resolver in
            let viewModel = resolver.resolve(MyPageViewModel.self)!
            return MyPageView(viewModel: viewModel)
        }
    }
    
}
