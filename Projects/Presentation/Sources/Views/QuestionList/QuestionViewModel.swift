//
//  QuestionViewModel.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/14.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain

public class QuestionViewModel: BaseViewModel {
    
    @Published private(set) var errorObject = ErrorObject()
    
    private let useCase: LoginUseCase
    private let cancelBag = CancelBag()
    
    public init(coordinator: CoordinatorProtocol, useCase: LoginUseCase) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
}
