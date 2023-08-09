//
//  ChatGPTAnswerDTO.swift
//  Data
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct ChatGPTAnswerDTO: Decodable {
    let id: String?
    let object: String?
    
    
    func toVO() -> ProblemSolvedVO {
        return ProblemSolvedVO(solved: solved ?? false)
    }
}
