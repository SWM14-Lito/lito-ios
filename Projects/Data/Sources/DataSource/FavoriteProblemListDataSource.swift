//
//  FavoriteProblemListDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol FavoriteProblemListDataSource {
    func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<ProblemsDTO, Error>
}

final public class DefaultFavoriteProblemListDataSource: FavoriteProblemListDataSource {
    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProblemAPI>()
    
    public func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<ProblemsDTO, Error> {
        moyaProvider.call(target: .favoriteProblemList(problemsQueryDTO))
    }
}
