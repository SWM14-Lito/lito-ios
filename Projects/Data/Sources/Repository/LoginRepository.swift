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
import AuthenticationServices
import KakaoSDKUser

final public class DefaultLoginRepository: NSObject, LoginRepository, ASAuthorizationControllerDelegate {
    
    public let appleLoginSubject = PassthroughSubject<OAuth.appleVO, ErrorVO>()
    
    public override init() {}
    
    public func performAppleLogin() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleLoginSubject.send(completion: .failure(.retryableError))
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let userName = (appleIDCredential.fullName?.namePrefix ?? "") + (appleIDCredential.fullName?.namePrefix ?? "")
            let userEmail = appleIDCredential.email
            let appleVO = OAuth.appleVO(userIdentifier: userIdentifier, userName: userName, userEmail: userEmail)
            appleLoginSubject.send(appleVO)
        default:
            break
        }
    }
    
    public func kakaoLogin() -> AnyPublisher<OAuth.kakaoVO, ErrorVO> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return kakaoLoginWithApp()
        } else {
            return kakaoLoginWithAccount()
        }
    }
    
    private func kakaoLoginWithApp() -> AnyPublisher<OAuth.kakaoVO, ErrorVO> {
        return Future<OAuth.kakaoVO, ErrorVO> { promise in
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
                        let kakaoVO = OAuth.kakaoVO(identifier: userIdentifier, userEmail: userEmail)
                        return promise(.success(kakaoVO))
                    }
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func kakaoLoginWithAccount() -> AnyPublisher<OAuth.kakaoVO, ErrorVO> {
        return Future<OAuth.kakaoVO, ErrorVO> { promise in
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
                        let kakaoVO = OAuth.kakaoVO(identifier: userIdentifier, userEmail: userEmail)
                        return promise(.success(kakaoVO))
                    }
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
