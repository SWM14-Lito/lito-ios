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
import KakaoSDKCommon
import KakaoSDKUser

public protocol OAuthDataSource {
    
    func appleLogin() -> AnyPublisher<OAuth.AppleDTO, Error>
    func kakaoLogin() -> AnyPublisher<OAuth.KakaoDTO, Error>
    
}

final public class DefaultOAuthDataSource: NSObject, OAuthDataSource, ASAuthorizationControllerDelegate {
    
    public override init() {}
    
    private let appleLoginSubject = PassthroughSubject<Result<OAuth.AppleDTO, OAuthErrorDTO.appleError>, Never>()
    
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
        request.requestedScopes = [.email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        return appleLoginPublisher
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if let authorizationError = error as? ASAuthorizationError {
            let appleErrorDTO = OAuthErrorDTO.appleError.authorizationError(authorizationError)
            #if DEBUG
            print(appleErrorDTO.debugString)
            #endif
            appleLoginSubject.send(.failure(appleErrorDTO))
        } else {
            appleLoginSubject.send(.failure(.commonError(error)))
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let userEmail = appleIDCredential.email
            let appleDTO = OAuth.AppleDTO(userIdentifier: userIdentifier, userEmail: userEmail)
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
                    if let kakaoErrorDTO = self.sdkErrorMapping(error: error) {
                        #if DEBUG
                        print(kakaoErrorDTO.debugString)
                        #endif
                        return promise(.failure(kakaoErrorDTO))
                    }
                    return promise(.failure(error))
                }
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        if let kakaoErrorDTO = self.sdkErrorMapping(error: error) {
                            #if DEBUG
                            print(kakaoErrorDTO.debugString)
                            #endif
                            return promise(.failure(kakaoErrorDTO))
                        }
                        return promise(.failure(OAuthErrorDTO.kakao.commonError(error)))
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
                    if let kakaoErrorDTO = self.sdkErrorMapping(error: error) {
                        #if DEBUG
                        print(kakaoErrorDTO.debugString)
                        #endif
                        return promise(.failure(kakaoErrorDTO))
                    }
                    return promise(.failure(OAuthErrorDTO.kakao.commonError(error)))
                }
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        if let kakaoErrorDTO = self.sdkErrorMapping(error: error) {
                            #if DEBUG
                            print(kakaoErrorDTO.debugString)
                            #endif
                            return promise(.failure(kakaoErrorDTO))
                        }
                        return promise(.failure(OAuthErrorDTO.kakao.commonError(error)))
                    }
                    if let userInfo = user?.kakaoAccount, let userId = user?.id {
                        let userIdentifier = String(userId)
                        let userEmail = userInfo.email
                        let kakaoDTO = OAuth.KakaoDTO(userIdentifier: userIdentifier, userEmail: userEmail)
                        return promise(.success(kakaoDTO))
                    }
                    
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func sdkErrorMapping(error: Error) -> OAuthErrorDTO.kakao? {
        guard let sdkError = error as? SdkError else { return nil }
        if sdkError.isClientFailed {
            let clientError = sdkError.getClientError()
            let clientFailureReason = clientError.reason
            let clientFailureMessage = clientError.message
            return OAuthErrorDTO.kakao.clientFailureReson(clientFailureReason, message: clientFailureMessage)
        }
        if sdkError.isApiFailed {
            let apiError = sdkError.getApiError()
            let apiFailureReason = apiError.reason
            let apiFailureInfo = apiError.info
            return OAuthErrorDTO.kakao.apiFailureReason(apiFailureReason, apiFailureInfo)
        }
        if sdkError.isAuthFailed {
            let authError = sdkError.getAuthError()
            let authFailureReason = authError.reason
            let authFailureInfo = authError.info
            return OAuthErrorDTO.kakao.authFailureReason(authFailureReason, authFailureInfo)
        }
        return nil
    }
    
}
