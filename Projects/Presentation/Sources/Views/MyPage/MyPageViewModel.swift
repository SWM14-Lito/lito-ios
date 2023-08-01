//
//  MyPageViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain

public class MyPageViewModel: BaseViewModel {
    
    private let useCase: MyPageUseCase
    @Published var imageData: Data?
    @Published var point: String = "0"
    @Published var nickName: String = "Unknown"
    @Published var introduce: String = "Unknown"
    @Published var alarmStatus: Bool = true
    
    public init(useCase: MyPageUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    public func postLogout() {
        useCase.postLogout()
            .sinkToResult { result in
                switch result {
                case .success:
                    KeyChainManager.delete(key: .accessToken)
                    KeyChainManager.delete(key: .refreshToken)
                    self.coordinator.popToRoot()
                case .failure:
                    break
                }
            }
            .store(in: cancelBag)
    }
    
}
