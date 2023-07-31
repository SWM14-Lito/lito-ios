//
//  OAuthRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

final public class DefaultOAuthRepository: OAuthRepository {
    
    private let dataSource: OAuthDataSource
    
    public init(dataSource: OAuthDataSource) {
        self.dataSource = dataSource
    }
    
    public func appleLogin() -> AnyPublisher<OAuth.AppleVO, Error> {
        dataSource.appleLogin()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func kakaoLogin() -> AnyPublisher<OAuth.KakaoVO, Error> {
        dataSource.kakaoLogin()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
}
