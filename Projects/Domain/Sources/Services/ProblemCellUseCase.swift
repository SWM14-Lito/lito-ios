//
//  ProblemCellUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProblemCellUseCase {

}

public final class DefaultProblemCellUseCase: ProblemCellUseCase {
    let repository: ProblemCellRepository
    
    public init(repository: ProblemCellRepository) {
        self.repository = repository
    }
}
