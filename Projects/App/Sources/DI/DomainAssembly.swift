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
            let oauthRepository = resolver.resolve(OAuthRepository.self)!
            let authRepository = resolver.resolve(AuthRepository.self)!
            return DefaultLoginUseCase(oauthRepository: oauthRepository, authRepository: authRepository)
        }
        
        container.register(ProfileSettingUseCase.self) { resolver in
            let userRepository = resolver.resolve(UserRepository.self)!
            let fileRepository = resolver.resolve(FileRepository.self)!
            let imageHelper = resolver.resolve(ImageHelper.self)!
            return DefaultProfileSettingUseCase(userRepository: userRepository, fileRepository: fileRepository, imageHelper: imageHelper)
        }
        
        // ------------------------ First Tab ------------------------
        container.register(LearningHomeUseCase.self) { resolver in
            let repository = resolver.resolve(ProblemRepository.self)!
            return DefaultLearningHomeUseCase(repository: repository)
        }
        container.register(ProblemDetailUseCase.self) { resolver in
            let repository = resolver.resolve(ProblemRepository.self)!
            return DefaultProblemDetailUseCase(repository: repository)
        }
        container.register(ProblemListUseCase.self) { resolver in
            let repository = resolver.resolve(ProblemRepository.self)!
            return DefaultProblemListUseCase(repository: repository)
        }
        container.register(SolvingProblemListUseCase.self) { resolver in
            let repository = resolver.resolve(ProblemRepository.self)!
            return DefaultSolvingProblemListUseCase(repository: repository)
        }
        container.register(FavoriteProblemListUseCase.self) { resolver in
            let repository = resolver.resolve(ProblemRepository.self)!
            return DefaultFavoriteProblemListUseCase(repository: repository)
        }
        container.register(ProblemSearchUseCase.self) { resolver in
            let repository = resolver.resolve(ProblemRepository.self)!
            return DefaultProblemSearchUseCase(repository: repository)
        }
        
        // ------------------------ Second Tab ------------------------
        
        // ------------------------ Third Tab ------------------------
        
        container.register(MyPageUseCase.self) { resolver in
            let userRepository = resolver.resolve(UserRepository.self)!
            let authRepository = resolver.resolve(AuthRepository.self)!
            return DefaultMyPageUseCase(userRepository: userRepository, authRepository: authRepository)
        }
        
    }
    
}
