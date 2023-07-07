//
//  LoginDataSource.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Combine
import CombineMoya
import Moya
import Domain

public protocol LoginDataSource {
    func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginDTO, Error>
}

public class DefaultLoginDataSource: LoginDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<LoginAPI>()
    
    public func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginDTO, Error> {
        print(NetworkConfiguration.developServerURL)
        switch OAuthProvider {
        case .apple(let appleVO):
            return moyaProvider.call(target: .apple(appleVO: appleVO))
                .eraseToAnyPublisher()
        case .kakao(let kakaoVO):
            return moyaProvider.call(target: .kakao(kakaoVO: kakaoVO))
                .eraseToAnyPublisher()
        }
    }
    
}
