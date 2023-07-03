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
    
    private let loginUseCase: LoginUseCase
    private let cancelBag = CancelBag()
    
    let appleLoginOnRequest: (ASAuthorizationAppleIDRequest) -> Void
    let appleLoginOnCompletion: (Result<ASAuthorization, Error>) -> Void
    
    public init(useCase: LoginUseCase, slip: Loadable<SlipVO> = .notRequested) {
        self.loginUseCase = useCase
        self.appleLoginOnRequest = useCase.appleLoginOnRequest
        self.appleLoginOnCompletion = useCase.appleLoginOnCompletion
    }
    
}
