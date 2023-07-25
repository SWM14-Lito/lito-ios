//
//  SolvingProblemViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain
import Combine

public final class SolvingProblemListViewModel: BaseViewModel {
    private let useCase: SolvingProblemListUseCase

    public init(useCase: SolvingProblemListUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
}
