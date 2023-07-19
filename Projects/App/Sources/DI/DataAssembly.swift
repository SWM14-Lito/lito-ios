//
//  DataAssembly.swift
//  App
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Swinject
import Domain
import Data
import Foundation

public struct DataAssembly: Assembly {
    
    public func assemble(container: Container) {
        // ------------------------ Common ------------------------
        // Example
        container.register(ExampleDataSource.self) { _ in
            return DefaultExampleDataSource()
        }
        container.register(ExampleRepository.self) { resolver in
            let dataSource = resolver.resolve(ExampleDataSource.self)!
            return DefaultExampleRepository(dataSource: dataSource)
        }
        // OAuthService
        container.register(OAuthServiceDataSource.self) { _ in
            return DefaultOAuthServiceDataSource()
        }
        // Login
        container.register(LoginDataSource.self) { _ in
            return DefaultLoginDataSource()
        }
        container.register(LoginRepository.self) { resolver in
            let oauthDataSource = resolver.resolve(OAuthServiceDataSource.self)!
            let loginDataSource = resolver.resolve(LoginDataSource.self)!
            return DefaultLoginRepository(oauthDataSource: oauthDataSource, loginDataSource: loginDataSource)
        }
        // ProfileSetting
        container.register(ProfileSettingDataSource.self) { _ in
            return DefaultProfileSettingDataSource()
        }
        container.register(ProfileSettingRepository.self) { resolver in
            let dataSource = resolver.resolve(ProfileSettingDataSource.self)!
            return DefaultProfileSettingRepository(dataSource: dataSource)
        }
        
        // ------------------------ First Tab ------------------------
        // LearningHome
        container.register(LearningHomeDataSource.self) { _ in
            return DefaultLearningHomeDataSource()
        }
        container.register(LearningHomeRepository.self) { resolver in
            let dataSource = resolver.resolve(LearningHomeDataSource.self)!
            return DefaultLearningHomeRepository(dataSource: dataSource)
        }
        // ProblemSolving
        container.register(ProblemSolvingDataSource.self) { _ in
            return DefaultProblemSolvingDataSource()
        }
        container.register(ProblemSolvingRepository.self) { resolver in
            let dataSource = resolver.resolve(ProblemSolvingDataSource.self)!
            return DefaultProblemSolvingRepository(dataSource: dataSource)
        }
        
        // ------------------------ Second Tab ------------------------
        
        // ------------------------ Third Tab ------------------------
    }
    
}
