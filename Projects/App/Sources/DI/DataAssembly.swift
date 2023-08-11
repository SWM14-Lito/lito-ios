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
        // Example
        container.register(ExampleDataSource.self) { _ in
            return DefaultExampleDataSource()
        }
        container.register(ExampleRepository.self) { resolver in
            let dataSource = resolver.resolve(ExampleDataSource.self)!
            return DefaultExampleRepository(dataSource: dataSource)
        }
        // Problem
        container.register(ProblemDataSource.self) { _ in
            return DefaultProblemDataSource()
        }
        container.register(ProblemRepository.self) { resolver in
            let dataSource = resolver.resolve(ProblemDataSource.self)!
            return DefaultProblemRepository(dataSource: dataSource)
        }
        // File
        container.register(FileDataSource.self) { _ in
            return DefaultFileDataSource()
        }
        container.register(FileRepository.self) { resolver in
            let dataSource = resolver.resolve(FileDataSource.self)!
            return DefaultFileRepository(dataSource: dataSource)
        }
        // User
        container.register(UserDataSource.self) { _ in
            return DefaultUserDataSource()
        }
        container.register(UserRepository.self) { resolver in
            let dataSource = resolver.resolve(UserDataSource.self)!
            return DefaultUserRepository(dataSource: dataSource)
        }
        // OAuth
        container.register(OAuthDataSource.self) { _ in
            return DefaultOAuthDataSource()
        }
        container.register(OAuthRepository.self) { resolver in
            let dataSource = resolver.resolve(OAuthDataSource.self)!
            return DefaultOAuthRepository(dataSource: dataSource)
        }
        // Auth
        container.register(AuthDataSource.self) { _ in
            return DefaultAuthDataSource()
        }
        container.register(AuthRepository.self) { resolver in
            let dataSource = resolver.resolve(AuthDataSource.self)!
            return DefaultAuthRepository(dataSource: dataSource)
        }
        // Chat
        container.register(ChatDataSource.self) { _ in
            return DefaultChatDataSource()
        }
        container.register(ChatRepository.self) { resolver in
            let dataSource = resolver.resolve(ChatDataSource.self)!
            return DefaultChatRepository(dataSource: dataSource)
        }
    }
    
}
