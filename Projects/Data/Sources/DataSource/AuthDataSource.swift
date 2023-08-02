//
//  AuthDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol AuthDataSource {
    func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginVO, Error>
    func postTokenReissue() -> AnyPublisher<TokenReissueDTO, Error>
    func postLogout() -> AnyPublisher<Void, Error>
}

final public class DefaultAuthDataSource: AuthDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<AuthAPI>()
    
    public func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginVO, Error> {
        switch OAuthProvider {
        case .apple(let appleVO):
            return moyaProvider.call(target: .appleLogin(appleVO: appleVO))
        case .kakao(let kakaoVO):
            return moyaProvider.call(target: .kakaoLogin(kakaoVO: kakaoVO))
        }
    }
    
    public func postTokenReissue() -> AnyPublisher<TokenReissueDTO, Error> {
        return moyaProvider.call(target: .reissueToken)
    }
    
    public func postLogout() -> AnyPublisher<Void, Error> {
        return moyaProvider.call(target: .logout)
    }
    
}
