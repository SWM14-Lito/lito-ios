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
    
    @Published private(set) var loginFeedback: Feedbackable
    private let useCase: LoginUseCase

    public init(coordinator: CoordinatorProtocol, useCase: LoginUseCase, loginFeedback: Feedbackable = .idle) {
        self.useCase = useCase
        self.loginFeedback = loginFeedback
        super.init(coordinator: coordinator)
    }
    
    public func kakaoLogin() {
        useCase.kakaoLogin()
            .sinkToResult({ result in
                switch result {
                case .success(let loginResultVO):
                    switch loginResultVO {
                    case .registered:
                        self.coordinator.pop()
                        self.coordinator.push(.rootTabView)
                    case .unregistered:
                        self.coordinator.pop()
                        self.coordinator.push(.profileSettingView)
                    }
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        switch errorVO {
                        case .fatalError:
                            self.errorObject.error = errorVO
                        case .retryableError:
                            self.errorObject.error = errorVO
                            self.errorObject.retryAction = self.appleLogin
                        }
                    }
                }
            })
            .store(in: cancelBag)
    }
    
    public func appleLogin() {
        useCase.appleLogin()
            .sinkToResult({ result in
                switch result {
                case .success(let loginResultVO):
                    switch loginResultVO {
                    case .registered:
                        self.coordinator.pop()
                        self.coordinator.push(.rootTabView)
                    case .unregistered:
                        self.coordinator.pop()
                        self.coordinator.push(.profileSettingView)
                    }
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        switch errorVO {
                        case .fatalError:
                            self.errorObject.error = errorVO
                        case .retryableError:
                            self.errorObject.error = errorVO
                            self.errorObject.retryAction = self.appleLogin
                        }
                    }
                }
            })
            .store(in: cancelBag)
    }
}
