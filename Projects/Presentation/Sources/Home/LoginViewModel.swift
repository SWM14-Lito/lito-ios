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

final public class LoginViewModel: ObservableObject {
    
    @Published private(set) var loginFeedback: Feedbackable
    
    private let useCase: LoginUseCase
    private let cancelBag = CancelBag()
    
    public init(useCase: LoginUseCase, loginFeedback: Feedbackable = .idle) {
        self.useCase = useCase
        self.loginFeedback = loginFeedback
        bindAppleLogin()
    }
    
    public func kakaoLogin() {
        useCase.kakaoLogin()
            .sinkToResult({ result in
                switch result {
                case .success(_):
                    print("kakao login Sucess")
                    //TODO: routing to next view
                case .failure(let error):
                    switch error {
                    case .fatalError:
                        self.loginFeedback = .failed(error)
                    case .retryableError:
                        self.loginFeedback = .idle
                    }
                }
            })
            .store(in: cancelBag)
    }
    
    public func performAppleLogin() {
        useCase.performAppleLogin()
    }
    
    private func bindAppleLogin() {
        useCase.bindAppleLogin()
            .sinkToResult({ result in
                switch result {
                case .success():
                    print("apple login sucess")
                    //TODO: routing to next view
                case .failure(let error):
                    switch error {
                    case .fatalError:
                        self.loginFeedback = .failed(error)
                    case .retryableError:
                        self.loginFeedback = .idle
                    }
                }
            })
            .store(in: cancelBag)
    }
    
}
