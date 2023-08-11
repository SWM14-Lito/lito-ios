//
//  BaseViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/05.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain

// BaseViewModel에는 ViewModel 들이 공통적으로 가지고 있어야하는 것들 정의
// 모든 ViewModel은 BaseViewModel을 상속

public class BaseViewModel: ObservableObject {
    @Published private(set) var errorObject = ErrorObject()
    let coordinator: CoordinatorProtocol
    let cancelBag = CancelBag()
    lazy var errorHandler: (Error) -> Void = { error in
        if let errorVO = error as? ErrorVO {
            if case .tokenExpired = errorVO {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.popToRoot()
                }
            }
        }
    }
    
    public init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func back() {
        coordinator.pop()
    }
    
    func popToRoot() {
        coordinator.popToRoot()
    }
}
