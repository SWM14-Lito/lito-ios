//
//  ProblemSearchViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import SwiftUI

public class ProblemSearchViewModel: BaseViewModel {
    private let useCase: ProblemSearchUseCase
    
    public init(useCase: ProblemSearchUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
}
