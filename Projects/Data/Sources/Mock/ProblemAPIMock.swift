//
//  ProblemAPIMock.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/21.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

#if DEBUG

extension ProblemAPI {
    var sampleData: Data {
        switch self {
        case .learningHome:
            let learningHomeDTO = LearningHomeDTO(userId: 1, profileImgUrl: nil, nickname: "테스트", question: "테스트", problemId: 1, subject: "테스트", favorite: false)
            if let data = try? JSONEncoder().encode(learningHomeDTO) {
                return data
            } else {
                return Data()
            }
        case .problemList:
            return Data()
        }
    }
    
}

#endif
