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
        
        container.register(Coordinator.self) { _ in
            return Coordinator()
        }
        
        container.register(RootTabView.self) { resolver in
            let coordinator = resolver.resolve(Coordinator.self)!
            return RootTabView(coordinator: coordinator)
        }
    }
    
}
