//
//  AuthServiceDataSource.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/05.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Combine
import Domain
import AuthenticationServices
import KakaoSDKUser

public protocol OAuthServiceDataSource {
    
    func appleLogin() -> AnyPublisher<OAuth.AppleDTO, Error>
    func kakaoLogin() -> AnyPublisher<OAuth.KakaoDTO, Error>
    
}

public class DefaultOAuthServiceDataSource: NSObject, OAuthServiceDataSource, ASAuthorizationControllerDelegate {
    
    public override init() {}
    
    private let appleLoginSubject = PassthroughSubject<Result<OAuth.AppleDTO, OAuthErrorDTO>, Never>()
    
    private var appleLoginPublisher: AnyPublisher<OAuth.AppleDTO, Error> {
        appleLoginSubject
            .flatMap { result -> AnyPublisher<OAuth.AppleDTO, Error> in
                switch result {
                case .success(let appleDTO):
                    return Just(appleDTO)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                case .failure(let error):
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func appleLogin() -> AnyPublisher<OAuth.AppleDTO, Error> {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        return appleLoginPublisher
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleLoginSubject.send(.failure(.apple(error)))
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let userName = (appleIDCredential.fullName?.namePrefix ?? "") + (appleIDCredential.fullName?.namePrefix ?? "")
            let userEmail = appleIDCredential.email
            let appleDTO = OAuth.AppleDTO(userIdentifier: userIdentifier, userName: userName, userEmail: userEmail)
            appleLoginSubject.send(.success(appleDTO))
        default:
            break
        }
    }
    
    public func kakaoLogin() -> AnyPublisher<OAuth.KakaoDTO, Error> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return kakaoLoginWithApp()
        } else {
            return kakaoLoginWithAccount()
        }
    }
    
    private func kakaoLoginWithApp() -> AnyPublisher<OAuth.KakaoDTO, Error> {
        return Future<OAuth.KakaoDTO, Error> { promise in
            UserApi.shared.loginWithKakaoTalk { (_, error) in
                if let error = error {
                    return promise(.failure(OAuthErrorDTO.kakao(error)))
                }
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        return promise(.failure(OAuthErrorDTO.apple(error)))
                    }
                    
                    if let userInfo = user?.kakaoAccount, let userId = user?.id {
                        let userIdentifier = String(userId)
                        let userEmail = userInfo.email
                        let kakaoDTO = OAuth.KakaoDTO(userIdentifier: userIdentifier, userEmail: userEmail)
                        return promise(.success(kakaoDTO))
                    }
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func kakaoLoginWithAccount() -> AnyPublisher<OAuth.KakaoDTO, Error> {
        return Future<OAuth.KakaoDTO, Error> { promise in
            UserApi.shared.loginWithKakaoAccount { (_, error) in
                if let error = error {
                    return promise(.failure(OAuthErrorDTO.kakao(error)))
                }
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        return promise(.failure(OAuthErrorDTO.kakao(error)))
                    }
                    
                    if let userInfo = user?.kakaoAccount, let userId = user?.id {
                        let userIdentifier = String(userId)
                        let userEmail = userInfo.email
                        let kakaoDTO = OAuth.KakaoDTO(userIdentifier: userIdentifier, userEmail: userEmail)
                        return promise(.success(kakaoDTO))
                    }
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
