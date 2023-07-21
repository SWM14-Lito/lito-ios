//
//  ProblemDetailDTO.swift
//  Data
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

// TODO: 서버 API 명세 나오면 변수명 수정 및 추가하기
public struct ProblemDetailDTO {
    public let question: String?
    public let answer: String?
    public let keyword: String?
    public let favorite: Bool?
    public let faqs: [ProblemFAQDTO]?
    
    func toVO() -> ProblemDetailVO {
        let faqVO = faqs?.map({ $0.toVO() })
        return ProblemDetailVO(question: question ?? "Unknown", answer: answer ?? "Unknown", keyword: "Unknown", favorite: ProblemFavoriteStatus(isFavorite: favorite), faqs: faqVO)
    }
}

public struct ProblemFAQDTO {
    public let question: String?
    public let answer: String?
    
    func toVO() -> ProblemFAQVO {
        return ProblemFAQVO(question: question ?? "Unknown", answer: answer ?? "Unknown")
    }
}
