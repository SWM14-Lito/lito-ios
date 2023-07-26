//
//  UserManager.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/26.
//  Copyright © 2023 com.lito. All rights reserved.
//
import Foundation
import Combine
import CombineMoya
import Moya
import Domain

final public class Auth: AuthDataSource {
    
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
    
}
