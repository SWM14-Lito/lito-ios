//
//  LoginRepository.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation
import Domain

final public class DefaultLoginRepository: LoginRepository {
    
    private let dataSource: OAuthServiceDataSource
    
    public init(dataSource: OAuthServiceDataSource) {
        self.dataSource = dataSource
    }
    
    public func performAppleLogin() {
        dataSource.performAppleLogin()
    }
    
    public func bindAppleLogin() -> AnyPublisher<OAuth.AppleVO, ErrorVO> {
        dataSource.appleLoginSubject
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }

    public func kakaoLogin() -> AnyPublisher<OAuth.KakaoVO, ErrorVO> {
        dataSource.kakaoLogin()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
}
