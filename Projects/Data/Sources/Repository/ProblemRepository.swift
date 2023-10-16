//
//  ProblemRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

final public class DefaultProblemRepository: ProblemRepository {
    private let dataSource: ProblemDataSource
    
    public init(dataSource: ProblemDataSource) {
        self.dataSource = dataSource
    }
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error> {
        dataSource.getProfileAndProblems()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        dataSource.toggleProblemFavorite(id: id)
    }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error> {
        dataSource.getProblemDetail(id: id)
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error> {
        dataSource.startSolvingProblem(id: id)
    }
    
    public func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error> {
        dataSource.submitAnswer(id: id, keyword: keyword)
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error> {
        dataSource.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .map { $0.toProblemListVO() }
            .eraseToAnyPublisher()
    }
    
    public func getProblemList(problemsQueryDTO: SearchedProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error> {
        dataSource.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .map { $0.toProblemListVO() }
            .eraseToAnyPublisher()
    }
    
    public func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<FavoriteProblemListVO, Error> {
        dataSource.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .map { $0.toFavoriteProblemListVO() }
            .eraseToAnyPublisher()
    }
    
    public func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<SolvingProblemListVO, Error> {
        dataSource.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .map { $0.toSolvingProblemListVO() }
            .eraseToAnyPublisher()
    }
    
    public func setProblemGoalCount(problemGoalCount: Int) {
        dataSource.setProblemGoalCount(problemGoalCount: problemGoalCount)
    }
    
    public func getProblemGoalCount() -> Int {
        dataSource.getProblemGoalCount()
    }
    
    public func setRecentKeywords(recentKeywords: [String]) {
        dataSource.setRecentKeywords(recentKeywords: recentKeywords)
    }
    
    public func getRecentKeywords() -> [String] {
        dataSource.getRecentKeywords()
    }
}
