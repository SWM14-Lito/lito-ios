//
//  ProblemSolvingDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol ProblemDetailDataSource {
    func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailDTO, Error>
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error>
    func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedDTO, Error>
}

final public class DefaultProblemDetailDataSource: ProblemDetailDataSource {
    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProblemAPI>()
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailDTO, Error> {
        moyaProvider.call(target: .problemDetail(id: id))
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .favoriteToggle(id: id))
    }
    
    public func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .enterProblem(id: id))
    }
    
    public func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedDTO, Error> {
        moyaProvider.call(target: .submitAnswer(id: id, keyword: keyword))
    }
}
