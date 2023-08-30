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

final public class LoginViewModel: BaseViewModel {
    
    private let useCase: LoginUseCase

    public init(coordinator: CoordinatorProtocol, useCase: LoginUseCase, toastHelper: ToastHelperProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
    }
    
    public func onKakaoLoginButttonClicked() {
        useCase.kakaoLogin()
            .sinkToResult({ result in
                switch result {
                case .success(let loginResultVO):
                    switch loginResultVO {
                    case .registered:
                        self.coordinator.push(.rootTabScene)
                    case .unregistered(let userAuthVO):
                        self.coordinator.push(.profileSettingScene(userAuthVO: userAuthVO))
                    }
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        switch errorVO {
                        case .fatalError:
                            self.errorObject.error = errorVO
                        case .retryableError:
                            self.errorObject.error = errorVO
                            self.errorObject.retryAction = self.onAppleLoginButtonClicked
                        case .tokenExpired:
                            break
                        }
                    }
                }
            })
            .store(in: cancelBag)
    }
    
    public func onAppleLoginButtonClicked() {
        useCase.appleLogin()
            .sinkToResult({ result in
                switch result {
                case .success(let loginResultVO):
                    switch loginResultVO {
                    case .registered:
                        self.coordinator.push(.rootTabScene)
                    case .unregistered(let userAuthVO):
                        self.coordinator.push(.profileSettingScene(userAuthVO: userAuthVO))
                    }
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        switch errorVO {
                        case .fatalError:
                            self.errorObject.error = errorVO
                        case .retryableError:
                            self.errorObject.error = errorVO
                            self.errorObject.retryAction = self.onAppleLoginButtonClicked
                        default:
                            break
                        }
                    }
                }
            })
            .store(in: cancelBag)
    }
}
