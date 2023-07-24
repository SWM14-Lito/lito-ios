//
//  ProblemDetailVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct ProblemDetailVO {
    public let problemId: Int
    public let problemQuestion: String
    public let problemAnswer: String
    public let problemKeyword: String
    public var favorite: ProblemFavoriteStatus
    public let faqs: [ProblemFAQVO]?
    
    public init(problemId: Int, problemQuestion: String, problemAnswer: String, problemKeyword: String, favorite: ProblemFavoriteStatus, faqs: [ProblemFAQVO]?) {
        self.problemId = problemId
        self.problemQuestion = problemQuestion
        self.problemAnswer = problemAnswer
        self.problemKeyword = problemKeyword
        self.favorite = favorite
        self.faqs = faqs
    }
}

public struct ProblemFAQVO: Hashable {
    public let faqQuestion: String
    public let faqAnswer: String
    
    public init(faqQuestion: String, faqAnswer: String) {
        self.faqQuestion = faqQuestion
        self.faqAnswer = faqAnswer
    }
}
