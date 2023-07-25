//
//  ProblemSolvingRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine

final public class DefaultProblemDetailRepository: ProblemDetailRepository {
    
    private let dataSource: ProblemDetailDataSource
    
    public init(dataSource: ProblemDetailDataSource) {
        self.dataSource = dataSource
    }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error> {
        dataSource.getProblemDetail(id: id)
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        dataSource.toggleProblemFavorite(id: id)
    }
}
