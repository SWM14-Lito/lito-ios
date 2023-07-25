//
//  FavoriteProblemListRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol FavoriteProblemListRepository {
    func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<[FavoriteProblemCellVO]?, Error>
}
