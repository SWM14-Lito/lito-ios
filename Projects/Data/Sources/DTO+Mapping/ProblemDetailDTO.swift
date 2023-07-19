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
    
    func toVO() -> ProblemDetailDTO {
        return ProblemDetailDTO(question: question ?? "Unknown", answer: answer ?? "Unknown", keyword: "Unknown")
    }
}
