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
import KakaoSDKUser

final public class DefaultLoginRepository: LoginRepository {
    
    public init() {}
    
    public func kakaoLogin() -> AnyPublisher<OAuth.kakaoVO, Error> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return kakaoLoginWithApp()
        } else {
            return kakaoLoginWithAccount()
        }
    }
    
    private func kakaoLoginWithApp() -> AnyPublisher<OAuth.kakaoVO, Error> {
        return Future<OAuth.kakaoVO, Error> { promise in
            UserApi.shared.loginWithKakaoTalk { (_, error) in
                if let error = error {
                    return promise(.failure(error))
                }
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        return promise(.failure(error))
                    }
                    
                    if let userInfo = user?.kakaoAccount, let userId = user?.id {
                        let userIdentifier = String(userId)
                        let userEmail = userInfo.email
                        let kakaoVO = OAuth.kakaoVO(identifier: userIdentifier, userEmail: userEmail)
                        return promise(.success(kakaoVO))
                    }
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func kakaoLoginWithAccount() -> AnyPublisher<OAuth.kakaoVO, Error> {
        return Future<OAuth.kakaoVO, Error> { promise in
            UserApi.shared.loginWithKakaoAccount { (_, error) in
                if let error = error {
                    return promise(.failure(error))
                }
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        return promise(.failure(error))
                    }
                    
                    if let userInfo = user?.kakaoAccount, let userId = user?.id {
                        let userIdentifier = String(userId)
                        let userEmail = userInfo.email
                        let kakaoVO = OAuth.kakaoVO(identifier: userIdentifier, userEmail: userEmail)
                        return promise(.success(kakaoVO))
                    }
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
