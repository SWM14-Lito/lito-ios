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
    
    func appleLogin() -> AnyPublisher<OAuth.AppleDTO, ErrorVO>
    func kakaoLogin() -> AnyPublisher<OAuth.KakaoDTO, ErrorVO>
    
}

public class DefaultOAuthServiceDataSource: NSObject, OAuthServiceDataSource, ASAuthorizationControllerDelegate {
    
    public override init() {}
    
    private let appleLoginSubject = PassthroughSubject<Result<OAuth.AppleDTO, ErrorVO>, Never>()
    
    private var appleLoginPublisher: AnyPublisher<OAuth.AppleDTO, ErrorVO> {
        appleLoginSubject
            .flatMap { result -> AnyPublisher<OAuth.AppleDTO, ErrorVO> in
                switch result {
                case .success(let appleDTO):
                    return Just(appleDTO)
                        .setFailureType(to: ErrorVO.self)
                        .eraseToAnyPublisher()
                case .failure(let error):
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func appleLogin() -> AnyPublisher<OAuth.AppleDTO, ErrorVO> {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        return appleLoginPublisher
            .eraseToAnyPublisher()
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleLoginSubject.send(.failure(.retryableError))
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
    
    public func kakaoLogin() -> AnyPublisher<OAuth.KakaoDTO, ErrorVO> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return kakaoLoginWithApp()
        } else {
            return kakaoLoginWithAccount()
        }
    }
    
    private func kakaoLoginWithApp() -> AnyPublisher<OAuth.KakaoDTO, ErrorVO> {
        return Future<OAuth.KakaoDTO, ErrorVO> { promise in
            UserApi.shared.loginWithKakaoTalk { (_, error) in
                if error != nil {
                    return promise(.failure(ErrorVO.retryableError))
                }
                UserApi.shared.me { (user, error) in
                    if error != nil {
                        return promise(.failure(ErrorVO.retryableError))
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
    
    private func kakaoLoginWithAccount() -> AnyPublisher<OAuth.KakaoDTO, ErrorVO> {
        return Future<OAuth.KakaoDTO, ErrorVO> { promise in
            UserApi.shared.loginWithKakaoAccount { (_, error) in
                if error != nil {
                    return promise(.failure(ErrorVO.retryableError))
                }
                UserApi.shared.me { (user, error) in
                    if error != nil {
                        return promise(.failure(ErrorVO.retryableError))
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
