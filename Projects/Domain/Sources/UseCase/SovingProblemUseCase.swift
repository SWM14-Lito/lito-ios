//
//  SovingProblemUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol SolvingProblemUseCase {

}

public final class DefaultSolvingProblemUseCase: SolvingProblemUseCase {
    private let repository: SolvingProblemRepository
    
    public init(repository: SolvingProblemRepository) {
        self.repository = repository
    }
}
