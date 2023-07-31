//
//  FavoriteProblemUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol FavoriteProblemListUseCase {
    func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<FavoriteProblemListVO, Error>
}

public final class DefaultFavoriteProblemListUseCase: FavoriteProblemListUseCase {
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
    
    public func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<FavoriteProblemListVO, Error> {
        repository.getProblemList(problemsQueryDTO: problemsQueryDTO)
    }
}
