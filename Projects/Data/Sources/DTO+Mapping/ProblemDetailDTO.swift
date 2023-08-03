//
//  ProblemDetailDTO.swift
//  Data
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct ProblemDetailDTO: Decodable {
    public let problemId: Int?
    public let problemQuestion: String?
    public let problemAnswer: String?
    public let problemKeyword: String?
    public let problemStatus: String?
    public let favorite: Bool?
    public let faqs: [ProblemFAQDTO]?
    
    func toVO() -> ProblemDetailVO {
        let faqVO = faqs?.map({ $0.toVO() })
        return ProblemDetailVO(
            problemId: problemId ?? 0,
            problemQuestion: problemQuestion ?? "Unknown",
            problemAnswer: problemAnswer ?? "Unknown",
            problemKeyword: problemKeyword ?? "Unknown",
            problemStatus: ProblemSolvedStatus(rawValue: problemStatus),
            favorite: ProblemFavoriteStatus(isFavorite: favorite),
            faqs: faqVO
        )
    }
    
    func toMutableVO() -> ProblemMutableVO {
        return ProblemMutableVO(
            problemId: problemId ?? 0,
            problemStatus: ProblemSolvedStatus(rawValue: problemStatus),
            favorite: ProblemFavoriteStatus(isFavorite: favorite)
        )
    }
}

public struct ProblemFAQDTO: Decodable {
    public let faqQuestion: String?
    public let faqAnswer: String?
    
    func toVO() -> ProblemFAQVO {
        return ProblemFAQVO(
            faqQuestion: faqQuestion ?? "Unknown",
            faqAnswer: faqAnswer ?? "Unknown"
        )
    }
}
