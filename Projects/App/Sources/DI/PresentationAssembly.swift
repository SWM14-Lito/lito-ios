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
    let toastHelper: ToastHelper
    
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
            return LoginViewModel(coordinator: coordinator, useCase: useCase, toastHelper: toastHelper)
        }
        container.register(LoginView.self) { resolver in
            let viewModel = resolver.resolve(LoginViewModel.self)!
            return LoginView(viewModel: viewModel)
        }
        // ProfileSetting
        container.register(ProfileSettingViewModel.self) { (resolver, userAuthVO: UserAuthVO) in
            let useCase = resolver.resolve(ProfileSettingUseCase.self)!
            return ProfileSettingViewModel(userAuthVO: userAuthVO, useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        
        container.register(ProfileSettingView.self) { (resolver, userAuthVO: UserAuthVO) in
            let viewModel = resolver.resolve(ProfileSettingViewModel.self, argument: userAuthVO)!
            return ProfileSettingView(viewModel: viewModel)
        }
        // RootTab
        container.register(RootTabView.self) { resolver in
            let tab1 = resolver.resolve(LearningHomeView.self)!
            let tab2 = resolver.resolve(PedigreeListView.self)!
            let tab3 = resolver.resolve(MyPageView.self)!
            return RootTabView(tab1: tab1, tab2: tab2, tab3: tab3)
        }
        // ImageHelper
        container.register(ImageHelper.self) { _ in
            return DefaultImageHelper()
        }
        // ------------------------ First Tab ------------------------
        // LearningHome
        container.register(LearningHomeViewModel.self) { resolver in
            let useCase = resolver.resolve(LearningHomeUseCase.self)!
            return LearningHomeViewModel(useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        container.register(LearningHomeView.self) { resolver in
            let viewModel = resolver.resolve(LearningHomeViewModel.self)!
            return LearningHomeView(viewModel: viewModel)
        }
        // ProblemList
        container.register(ProblemListViewModel.self) { resolver in
            let useCase = resolver.resolve(ProblemListUseCase.self)!
            return ProblemListViewModel(useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        
        container.register(ProblemListView.self) { resolver in
            let viewModel = resolver.resolve(ProblemListViewModel.self)!
            return ProblemListView(viewModel: viewModel)
        }
        // SolvingProblemList
        container.register(SolvingProblemListViewModel.self) { resolver in
            let useCase = resolver.resolve(SolvingProblemListUseCase.self)!
            return SolvingProblemListViewModel(useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        
        container.register(SolvingProblemListView.self) { resolver in
            let viewModel = resolver.resolve(SolvingProblemListViewModel.self)!
            return SolvingProblemListView(viewModel: viewModel)
        }
        // FavoriteProblemList
        container.register(FavoriteProblemListViewModel.self) { resolver in
            let useCase = resolver.resolve(FavoriteProblemListUseCase.self)!
            return FavoriteProblemListViewModel(useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        
        container.register(FavoriteProblemListView.self) { resolver in
            let viewModel = resolver.resolve(FavoriteProblemListViewModel.self)!
            return FavoriteProblemListView(viewModel: viewModel)
        }
        // ProblemDetail
        container.register(ProblemDetailViewModel.self) { (resolver, id: Int) in
            let useCase = resolver.resolve(ProblemDetailUseCase.self)!
            return ProblemDetailViewModel(problemId: id, useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        
        container.register(ProblemDetailView.self) { (resolver, id: Int) in
            let viewModel = resolver.resolve(ProblemDetailViewModel.self, argument: id)!
            return ProblemDetailView(viewModel: viewModel)
        }
        // ChatGPT
        container.register(ChattingViewModel.self) { (resolver, question: String, answer: String, problemId: Int) in
            let useCase = resolver.resolve(ChattingUseCase.self)!
            return ChattingViewModel(question: question, answer: answer, problemId: problemId, useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        
        container.register(ChattingView.self) { (resolver, question: String, answer: String, problemId: Int) in
            let viewModel = resolver.resolve(ChattingViewModel.self, arguments: question, answer, problemId)!
            return ChattingView(viewModel: viewModel)
        }
        // ProblemSearch
        container.register(ProblemSearchViewModel.self) { resolver in
            let useCase = resolver.resolve(ProblemSearchUseCase.self)!
            return ProblemSearchViewModel(useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        container.register(ProblemSearchView.self) { resolver in
            let viewModel = resolver.resolve(ProblemSearchViewModel.self)!
            return ProblemSearchView(viewModel: viewModel)
        }
        // ------------------------ Second Tab ------------------------
        // PedigreeList
        container.register(PedigreeListViewModel.self) { _ in
            return PedigreeListViewModel(coordinator: coordinator, toastHelper: toastHelper)
        }
        container.register(PedigreeListView.self) { resolver in
            let viewModel = resolver.resolve(PedigreeListViewModel.self)!
            return PedigreeListView(viewModel: viewModel)
        }
        // ------------------------ Third Tab ------------------------
        // MyPage
        container.register(MyPageViewModel.self) { resolver in
            let useCase = resolver.resolve(MyPageUseCase.self)!
            return MyPageViewModel(useCase: useCase, coordinator: coordinator, toastHelper: toastHelper)
        }
        .inObjectScope(.container)
        
        container.register(MyPageView.self) { resolver in
            let viewModel = resolver.resolve(MyPageViewModel.self)!
            return MyPageView(viewModel: viewModel)
        }
        
        container.register(ModifyProfileView.self) { resolver in
            let viewModel = resolver.resolve(MyPageViewModel.self)!
            return ModifyProfileView(viewModel: viewModel)
        }
    }
    
}
