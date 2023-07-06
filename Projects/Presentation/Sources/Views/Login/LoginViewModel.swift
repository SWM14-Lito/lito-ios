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

final public class LoginViewModel: BaseViewModel, ObservableObject {
    
    @Published private(set) var errorObject = ErrorObject()
    @Published private(set) var loginFeedback: Feedbackable
    
    private let useCase: LoginUseCase
    private let cancelBag = CancelBag()
    
    public init(coordinator: CoordinatorProtocol, useCase: LoginUseCase, loginFeedback: Feedbackable = .idle) {
        self.useCase = useCase
        self.loginFeedback = loginFeedback
        super.init(coordinator: coordinator)
    }
    
    public func kakaoLogin() {
        useCase.kakaoLogin()
            .sinkToResult({ result in
                switch result {
                case .success(_):
                    self.coordinator.push(.profileSettingView("test"))
                case .failure(let error):
                    switch error {
                    case .fatalError:
                        self.errorObject.error = error
                    case .retryableError:
                        self.errorObject.error = error
                        self.errorObject.retryAction = self.kakaoLogin
                    }
                }
            })
            .store(in: cancelBag)
    }
    
    public func appleLogin() {
        useCase.appleLogin()
            .sinkToResult({ result in
                switch result {
                case .success(_):
                    self.coordinator.push(.profileSettingView("test"))
                case .failure(let error):
                    switch error {
                    case .fatalError:
                        self.errorObject.error = error
                    case .retryableError:
                        self.errorObject.error = error
                        self.errorObject.retryAction = self.appleLogin
                    }
                }
            })
            .store(in: cancelBag)
    }
}
