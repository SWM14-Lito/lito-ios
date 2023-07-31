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
import Moya

final public class DefaultLoginRepository: LoginRepository {
    
    private let oauthDataSource: OAuthDataSource
    private let loginDataSource: LoginDataSource
    
    public init(oauthDataSource: OAuthDataSource, loginDataSource: LoginDataSource) {
        self.oauthDataSource = oauthDataSource
        self.loginDataSource = loginDataSource
    }
    
    public func appleLogin() -> AnyPublisher<OAuth.AppleVO, Error> {
        oauthDataSource.appleLogin()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func kakaoLogin() -> AnyPublisher<OAuth.KakaoVO, Error> {
        oauthDataSource.kakaoLogin()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginVO, Error> {
        loginDataSource.postLoginInfo(OAuthProvider: OAuthProvider)
    }
    
}
