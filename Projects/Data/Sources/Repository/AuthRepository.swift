//
//  AuthRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

final public class DefaultAuthRepository: AuthRepository {
    
    private let dataSource: AuthDataSource
    
    public init(dataSource: AuthDataSource) {
        self.dataSource = dataSource
    }
    
    public func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginVO, Error> {
        dataSource.postLoginInfo(OAuthProvider: OAuthProvider)
    }
    
    public func postLogout() -> AnyPublisher<Void, Error> {
        dataSource.postLogout()
    }
}
