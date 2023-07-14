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
    
    private let repository: LoginRepository
    
    private var cancleBag = Set<AnyCancellable>()
    
    public init(repository: LoginRepository) {
        self.repository = repository
    }
    
    public func appleLogin() -> AnyPublisher<LoginResultVO, Error> {
        repository.appleLogin()
            .flatMap { appleVO -> AnyPublisher<LoginResultVO, Error> in
                self.repository.postLoginInfo(OAuthProvider: OAuth.apple(appleVO))
                    .catch { error -> Fail in
                        return Fail(error: error)
                    }
                    .map { loginVO in
                        KeyChainManager.create(key: .accessToken, token: loginVO.accessToken)
                        KeyChainManager.create(key: .refreshToken, token: loginVO.refreshToken)
                        return loginVO.registered ? .registered : .unregistered
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func kakaoLogin() -> AnyPublisher<LoginResultVO, Error> {
        repository.kakaoLogin()
            .flatMap { kakaoVO -> AnyPublisher<LoginResultVO, Error> in
                self.repository.postLoginInfo(OAuthProvider: OAuth.kakao(kakaoVO))
                    .catch { error -> Fail in
                        return Fail(error: error)
                    }
                    .map { loginVO in
                        KeyChainManager.create(key: .accessToken, token: loginVO.accessToken)
                        KeyChainManager.create(key: .refreshToken, token: loginVO.refreshToken)
                        return loginVO.registered ? .registered : .unregistered
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
}
