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
}

final public class DefaultAuthDataSource: AuthDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<LoginAPI>()
    
    public func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginVO, Error> {
        switch OAuthProvider {
        case .apple(let appleVO):
            return moyaProvider.call(target: .apple(appleVO: appleVO))
        case .kakao(let kakaoVO):
            return moyaProvider.call(target: .kakao(kakaoVO: kakaoVO))
        }
    }
    
}
