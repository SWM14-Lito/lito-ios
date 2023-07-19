//
//  ProblemSolvingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

public protocol ProblemSolvingUseCase {

}

public final class DefaultProblemSolvingUseCase: ProblemSolvingUseCase {
    private let repository: ProblemSolvingRepository
    
    public init(repository: ProblemSolvingRepository) {
        self.repository = repository
    }
}
