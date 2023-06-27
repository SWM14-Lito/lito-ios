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
        container.register(HomeDataSource.self) { _ in
            return DefaultHomeDataSource()
        }
        
        container.register(HomeRepository.self) { resolver in
            let dataSource = resolver.resolve(HomeDataSource.self)!
            return DefaultHomeRepository(dataSource: dataSource)
        }
        
    }
}
