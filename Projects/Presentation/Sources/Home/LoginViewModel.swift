//
//  LoginViewModel.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine
import Domain
import AuthenticationServices

final public class LoginViewModel: ObservableObject {
    //
    //    @Published private(set) var slip: Loadable<SlipVO>
    //
    //    private let homeUseCase: HomeUseCase
    //    private let cancelBag = CancelBag()
    //
    //    public init(homeUseCase: HomeUseCase, slip: Loadable<SlipVO> = .notRequested) {
    //        self.slip = slip
    //        self.homeUseCase = homeUseCase
    //    }
    
    let appleLoginOnRequest: (ASAuthorizationAppleIDRequest) -> Void = { request in
        request.requestedScopes = [.fullName, .email]
    }
    
    let appleLoginOnCompletion: (Result<ASAuthorization, Error>) -> Void  = { result in
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
    
    public init() {}
    
}
