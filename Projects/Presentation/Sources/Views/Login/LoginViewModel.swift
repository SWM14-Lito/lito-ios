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
        lastNetworkAction = onKakaoLoginButttonClicked
        useCase.kakaoLogin()
            .sinkToResultWithErrorHandler({ loginResultVO in
                switch loginResultVO {
                case .registered:
                    self.coordinator.push(.rootTabScene)
                case .unregistered(let userAuthVO):
                    self.coordinator.push(.profileSettingScene(userAuthVO: userAuthVO))
                }
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    public func onAppleLoginButtonClicked() {
        lastNetworkAction = onAppleLoginButtonClicked
        useCase.appleLogin()
            .sinkToResultWithErrorHandler({ loginResultVO in
                switch loginResultVO {
                case .registered:
                    self.coordinator.push(.rootTabScene)
                case .unregistered(let userAuthVO):
                    self.coordinator.push(.profileSettingScene(userAuthVO: userAuthVO))
                }
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
}
