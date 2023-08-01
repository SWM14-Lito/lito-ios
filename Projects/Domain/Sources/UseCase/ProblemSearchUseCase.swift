//
//  ProblemSearchUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProblemSearchUseCase {

}

public final class DefaultProblemSearchUseCase: ProblemSearchUseCase {
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
}
