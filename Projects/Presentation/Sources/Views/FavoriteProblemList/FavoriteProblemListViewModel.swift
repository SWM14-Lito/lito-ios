//
//  FavoriteProblemListViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain
import Combine

public final class FavoriteProblemListViewModel: BaseViewModel {
    private let useCase: FavoriteProblemListUseCase

    public init(useCase: FavoriteProblemListUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
}
