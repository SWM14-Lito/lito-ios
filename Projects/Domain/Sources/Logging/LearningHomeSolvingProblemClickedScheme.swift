//
//  LearningHomeSolvingProblemClickedScheme.swift
//  Domain
//
//  Created by 김동락 on 2023/10/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import SWMLogging

public struct LearningHomeSolvingProblemClickedScheme: ClickScheme {
    
    public var eventLogName = "LearningHomeSolvingProblemClicked"
    public var screenName = "LearningHome"
    public var logVersion = 1
    public var logData: [String: AnyEncodable] = [:]
    
    // 학습목표, 학습퍼센트, 추천문제 개수, 추천문제 풀이한 개수, 문제 id, 문제 카테고리, 문제 질문, 찜여부
    public init(learningGoal: Int?, learningPercent: Float?, recommendedProblemsCount: Int?, recommendedProblemsSolvedCount: Int?, problemId: Int?, problemCategory: String?, problemQuestion: String?, problemFavorite: Bool?) {
        if let learningGoal = learningGoal { self.logData["learningGoal"] = .int(learningGoal)}
        if let learningPercent = learningPercent { self.logData["learningPercent"] = .float(learningPercent)}
        if let recommendedProblemsCount = recommendedProblemsCount { self.logData["recommendedProblemsCount"] = .int(recommendedProblemsCount)}
        if let recommendedProblemsSolvedCount = recommendedProblemsSolvedCount { self.logData["recommendedProblemsSolvedCount"] = .int(recommendedProblemsSolvedCount)}
        if let problemId = problemId { self.logData["problemId"] = .int(problemId)}
        if let problemCategory = problemCategory { self.logData["problemCategory"] = .string(problemCategory)}
        if let problemQuestion = problemQuestion { self.logData["problemQuestion"] = .string(problemQuestion)}
        if let problemFavorite = problemFavorite { self.logData["problemFavorite"] = .bool(problemFavorite)}
    }
    
    public class Builder {
        var learningGoal: Int?
        var learningPercent: Float?
        var recommendedProblemsCount: Int?
        var recommendedProblemsSolvedCount: Int?
        var problemId: Int?
        var problemCategory: String?
        var problemQuestion: String?
        var problemFavorite: Bool?
        
        public init() { }

        public func setLearningGoal(_ learningGoal: Int) -> Builder {
            self.learningGoal = learningGoal
            return self
        }
        public func setLearningPercent(_ learningPercent: Float) -> Builder {
            self.learningPercent = learningPercent
            return self
        }
        public func setRecommendedProblemsCount(_ recommendedProblemsCount: Int) -> Builder {
            self.recommendedProblemsCount = recommendedProblemsCount
            return self
        }
        public func setrecommendedProblemsSolvedCount(_ recommendedProblemsSolvedCount: Int) -> Builder {
            self.recommendedProblemsSolvedCount = recommendedProblemsSolvedCount
            return self
        }
        public func setProblemId(_ problemId: Int) -> Builder {
            self.problemId = problemId
            return self
        }
        public func setProblemCategory(_ problemCategory: String) -> Builder {
            self.problemCategory = problemCategory
            return self
        }
        public func setProblemQuestion(_ problemQuestion: String) -> Builder {
            self.problemQuestion = problemQuestion
            return self
        }
        public func setProblemFavorite(_ problemFavorite: Bool) -> Builder {
            self.problemFavorite = problemFavorite
            return self
        }
        public func build() -> SWMLoggingScheme {
            return LearningHomeSolvingProblemClickedScheme(learningGoal: learningGoal, learningPercent: learningPercent, recommendedProblemsCount: recommendedProblemsCount, recommendedProblemsSolvedCount: recommendedProblemsSolvedCount, problemId: problemId, problemCategory: problemCategory, problemQuestion: problemQuestion, problemFavorite: problemFavorite)
        }

    }

}

