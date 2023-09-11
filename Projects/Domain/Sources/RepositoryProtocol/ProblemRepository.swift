//
//  ProblemRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProblemRepository {
    func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error>
    
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    
    func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error>
    
    func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error>
    
    func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error>
    
    func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error>
    
    func getProblemList(problemsQueryDTO: SearchedProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error>
    
    func getProblemList(problemsQueryDTO: FavoriteProblemsQueryDTO) -> AnyPublisher<FavoriteProblemListVO, Error>
    
    func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<SolvingProblemListVO, Error>
    
    func setProblemGoalCount(problemGoalCount: Int)
    
    func getProblemGoalCount() -> Int
    
    func setRecentKeywords(recentKeywords: [String])
    
    func getRecentKeywords() -> [String]
}
