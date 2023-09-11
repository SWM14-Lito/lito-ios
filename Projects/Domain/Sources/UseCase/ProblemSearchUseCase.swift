//
//  ProblemSearchUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProblemSearchUseCase {
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func getProblemList(problemsQueryDTO: SearchedProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error>
    func setRecentKeywords(recentKeywords: [String])
    func getRecentKeywords() -> [String]
}

public final class DefaultProblemSearchUseCase: ProblemSearchUseCase {
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
    
    public func getProblemList(problemsQueryDTO: SearchedProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error> {
        repository.getProblemList(problemsQueryDTO: problemsQueryDTO)
    }
    
    public func setRecentKeywords(recentKeywords: [String]) {
        let limit = 10
        var limitedRecentKeywords = recentKeywords
        if limitedRecentKeywords.count > limit {
            limitedRecentKeywords = Array(limitedRecentKeywords[(limitedRecentKeywords.count-limit)...])
        }
        repository.setRecentKeywords(recentKeywords: limitedRecentKeywords)
    }
    
    public func getRecentKeywords() -> [String] {
        repository.getRecentKeywords()
    }
}
