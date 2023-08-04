//
//  LoginUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol LoginUseCase {
    
    func kakaoLogin() -> AnyPublisher<LoginResultVO, Error>
    func appleLogin() -> AnyPublisher<LoginResultVO, Error>
    
}

public final class DefaultLoginUseCase: LoginUseCase {
    
    private let oauthRepository: OAuthRepository
    private let authRepository: AuthRepository
    
    private var cancleBag = Set<AnyCancellable>()
    
    public init(oauthRepository: OAuthRepository, authRepository: AuthRepository) {
        self.oauthRepository = oauthRepository
        self.authRepository = authRepository
    }
    
    public func appleLogin() -> AnyPublisher<LoginResultVO, Error> {
        oauthRepository.appleLogin()
            .flatMap { appleVO -> AnyPublisher<LoginResultVO, Error> in
                self.authRepository.postLoginInfo(OAuthProvider: OAuth.apple(appleVO))
                    .catch { error -> Fail in
                        return Fail(error: error)
                    }
                    .map { loginVO in
                        if loginVO.registered {
                            let userAuthVO = UserAuthVO(accessToken: loginVO.accessToken, refreashToken: loginVO.refreshToken, userId: loginVO.userId)
                            KeyChainManager.createUserInfo(userAuthVO: userAuthVO)
                        }
                        return loginVO.registered ? .registered : .unregistered(userAuthVO: UserAuthVO(accessToken: loginVO.accessToken, refreashToken: loginVO.refreshToken, userId: loginVO.userId))
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func kakaoLogin() -> AnyPublisher<LoginResultVO, Error> {
        oauthRepository.kakaoLogin()
            .flatMap { kakaoVO -> AnyPublisher<LoginResultVO, Error> in
                self.authRepository.postLoginInfo(OAuthProvider: OAuth.kakao(kakaoVO))
                    .catch { error -> Fail in
                        return Fail(error: error)
                    }
                    .map { loginVO in
                        if loginVO.registered {
                            let userAuthVO = UserAuthVO(accessToken: loginVO.accessToken, refreashToken: loginVO.refreshToken, userId: loginVO.userId)
                            KeyChainManager.createUserInfo(userAuthVO: userAuthVO)
                        }
                        return loginVO.registered ? .registered : .unregistered(userAuthVO: UserAuthVO(accessToken: loginVO.accessToken, refreashToken: loginVO.refreshToken, userId: loginVO.userId))
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
}
