//
//  ProblemSolvingViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import SwiftUI

public class ProblemSolvingViewModel: BaseViewModel {
    private let useCase: ProblemSolvingUseCase
    private var problemId: Int?
    @Published var problemDetailVO: ProblemDetailVO?
    
    public init(useCase: ProblemSolvingUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    func getProblemInfo() {
        
    }
    
    func setProblemId(id: Int) {
        problemId = id
    }
}
