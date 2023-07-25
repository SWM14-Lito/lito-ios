//
//  FavoriteProblemListRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine
import UIKit

final public class DefaultFavoriteProblemListRepository: FavoriteProblemListRepository {
    
    private let dataSource: FavoriteProblemListDataSource
    
    public init(dataSource: FavoriteProblemListDataSource) {
        self.dataSource = dataSource
    }
    
    public func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<[FavoriteProblemCellVO]?, Error> {
        dataSource.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .map { $0.toFavoriteProblemCellVO() }
            .eraseToAnyPublisher()
    }
}
