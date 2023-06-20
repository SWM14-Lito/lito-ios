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
            // TODO: Data 모듈에서 설정하도록 분리하는게 좋을까?
            let session = NetworkConfiguration.configuredURLSession()
            let baseURL = "https://api.adviceslip.com/advice"
            return DefaultHomeDataSource(session: session, baseURL: baseURL)
        }
        
        container.register(HomeRepository.self) { resolver in
            let dataSource = resolver.resolve(HomeDataSource.self)!
            return DefaultHomeRepository(dataSource: dataSource)
        }
        
    }
}
