//
//  DomainAssembly.swift
//  App
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Domain
import Swinject

public struct DomainAssembly: Assembly {
    
    public func assemble(container: Container) {
        // ------------------------ Common ------------------------
        container.register(ExampleUseCase.self) { resolver in
            let repository = resolver.resolve(ExampleRepository.self)!
            return DefaultExampleUseCase(repository: repository)
        }
        
        container.register(LoginUseCase.self) { resolver in
            let repository = resolver.resolve(LoginRepository.self)!
            return DefaultLoginUseCase(repository: repository)
        }
        
        container.register(ProfileSettingUseCase.self) { resolver in
            let repository = resolver.resolve(ProfileSettingRepository.self)!
            let imageHelper = resolver.resolve(ImageHelper.self)!
            return DefaultProfileSettingUseCase(repository: repository, imageHelper: imageHelper)
        }
        
        // ------------------------ First Tab ------------------------
        container.register(LearningHomeUseCase.self) { resolver in
            let repository = resolver.resolve(LearningHomeRepository.self)!
            return DefaultLearningHomeUseCase(repository: repository)
        }
        container.register(ProblemSolvingUseCase.self) { resolver in
            let repository = resolver.resolve(ProblemSolvingRepository.self)!
            return DefaultProblemSolvingUseCase(repository: repository)
        }
        container.register(ProblemListUseCase.self) { resolver in
            let repository = resolver.resolve(ProblemListRepository.self)!
            return DefaultProblemListUseCase(repository: repository)
        }
        
        // ------------------------ Second Tab ------------------------
        
        // ------------------------ Third Tab ------------------------
        
    }
    
}
