//
//  ProblemDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol ProblemDataSource {
    func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<ProblemListDTO, Error>
    func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<ProblemListDTO, Error>
    func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListDTO, Error>
    func getProblemList(problemsQueryDTO: SearchedProblemsQueryDTO) -> AnyPublisher<ProblemListDTO, Error>
    func getProfileAndProblems() -> AnyPublisher<LearningHomeDTO, Error>
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailDTO, Error>
    func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error>
    func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedDTO, Error>
}

final public class DefaultProblemDataSource: ProblemDataSource {
    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProblemAPI>()
    
    public func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<ProblemListDTO, Error> {
        moyaProvider.call(target: .solvingProblemList(problemsQueryDTO))
    }
    
    public func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<ProblemListDTO, Error> {
        moyaProvider.call(target: .favoriteProblemList(problemsQueryDTO))
    }
    
    public func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListDTO, Error> {
        moyaProvider.call(target: .problemList(problemsQueryDTO))
    }
    
    public func getProblemList(problemsQueryDTO: SearchedProblemsQueryDTO) -> AnyPublisher<ProblemListDTO, Error> {
        moyaProvider.call(target: .searchedProblemList(problemsQueryDTO))
    }
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeDTO, Error> {
        moyaProvider.call(target: .learningHome)
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .favoriteToggle(id: id))
    }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailDTO, Error> {
        moyaProvider.call(target: .problemDetail(id: id))
    }

    public func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .enterProblem(id: id))
    }
    
    public func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedDTO, Error> {
        moyaProvider.call(target: .submitAnswer(id: id, keyword: keyword))
    }

}
