//
//  ProblemSolvingViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public class ProblemSolvingViewModel: BaseViewModel {
    private let useCase: ProblemSolvingUseCase
    
    public init(useCase: ProblemSolvingUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
}
