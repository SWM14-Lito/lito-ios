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
    
    private let oauthDataSource: OAuthServiceDataSource
    private let loginDataSource: LoginDataSource
    
    public init(oauthDataSource: OAuthServiceDataSource, loginDataSource: LoginDataSource) {
        self.oauthDataSource = oauthDataSource
        self.loginDataSource = loginDataSource
    }
    
    public func appleLogin() -> AnyPublisher<OAuth.AppleVO, Error> {
        oauthDataSource.appleLogin()
            // 1차적으로 이곳에서 oauthErrorDTO 를 핸들링
            // 만약 catch한 error 가 추가적인 액션을 통해 해결 가능성 있는 error 라면 repository or useCase 어디서 처리 해야할까?
            .catch({ error -> Fail in
                if let oauthErrorDTO = error as? OAuthErrorDTO {
                    #if DEBUG
                    print(oauthErrorDTO.debugString)
                    #endif
                    return Fail(error: oauthErrorDTO.toVO())
                }
                return Fail(error: ErrorVO.fatalError)
            })
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func kakaoLogin() -> AnyPublisher<OAuth.KakaoVO, Error> {
        oauthDataSource.kakaoLogin()
            .catch({ error -> Fail in
                if let oauthError = error as? OAuthErrorDTO {
                    #if DEBUG
                    print(oauthError.debugString)
                    #endif
                    return Fail(error: oauthError.toVO())
                }
                return Fail(error: ErrorVO.fatalError)
            })
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginVO, Error> {
        return loginDataSource.postLoginInfo(OAuthProvider: OAuthProvider)
            .catch { error -> Fail in
                if let networkError = error as? NetworkErrorDTO {
                    #if DEBUG
                    print(networkError.debugString)
                    #endif
                    return Fail(error: networkError)
                }
                return Fail(error: ErrorVO.fatalError)
            }
            .eraseToAnyPublisher()
    }
    
}
