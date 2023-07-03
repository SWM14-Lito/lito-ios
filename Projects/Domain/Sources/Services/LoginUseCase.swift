//
//  LoginUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation
import AuthenticationServices

public protocol LoginUseCase {
    
    var appleLoginOnRequest: (ASAuthorizationAppleIDRequest) -> Void { get }
    var appleLoginOnCompletion: (Result<ASAuthorization, Error>) -> Void { get }
    func kakaoLogin()
}

public final class DefaultLoginUseCase: LoginUseCase {
    
    let repository: LoginRepository
    
    private var cancleBag = Set<AnyCancellable>()

    public init(repository: LoginRepository) {
        self.repository = repository
    }
    
    public let appleLoginOnRequest: (ASAuthorizationAppleIDRequest) -> Void = { request in
        request.requestedScopes = [.fullName, .email]
    }
    
    public let appleLoginOnCompletion: (Result<ASAuthorization, Error>) -> Void  = { result in
        switch result {
        case .success(let authorization):
            print("apple login sucess")
            switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                /*
                 Info
                 appleIDCredential.fullName
                 appleIDCredential.email
                 appleIDCredential.user
                 appleIDCredential.authorizationCode
                 appleIDCredential.identityToken
                 */
                break
            default:
                break
            }
        case .failure(let error):
            print("error")
        }
    }
    
    public func kakaoLogin() {
        repository.kakaoLogin()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            } receiveValue: { kakaoVO in
                print(kakaoVO)
            }
            .store(in: &cancleBag)

    }
    
}

//#if DEBUG
//public final class StubLoginUseCase: LoginUseCase {
//
//    public init() {}
//
//    public func load() -> AnyPublisher<SlipVO, NetworkErrorVO> {
//        return Just(SlipVO.mock)
//            .setFailureType(to: NetworkErrorVO.self)
//            .eraseToAnyPublisher()
//    }
//
//}
//#endif
