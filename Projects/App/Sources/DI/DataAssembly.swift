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
        container.register(ExampleDataSource.self) { _ in
            return DefaultExampleDataSource()
        }
        
        container.register(ExampleRepository.self) { resolver in
            let dataSource = resolver.resolve(ExampleDataSource.self)!
            return DefaultExampleRepository(dataSource: dataSource)
        }
        
        container.register(OAuthServiceDataSource.self) { _ in
            return DefaultOAuthServiceDataSource()
        }
        
        container.register(LoginRepository.self) { resolver in
            let dataSource = resolver.resolve(OAuthServiceDataSource.self)!
            return DefaultLoginRepository(dataSource: dataSource)
        }
        
    }
    
}
