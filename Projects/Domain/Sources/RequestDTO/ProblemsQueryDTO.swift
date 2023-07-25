//
//  ProblemsQueryDTO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct ProblemsQueryDTO {
    public let lastProblemId: Int?
    public let subjectId: Int?
    public let problemStatus: String?
    public let query: String?
    public let size: String?
    
    public init(lastProblemId: Int? = nil, subjectId: Int? = nil, problemStatus: String? = nil, query: String? = nil, size: String? = nil) {
        self.lastProblemId = lastProblemId
        self.subjectId = subjectId
        self.problemStatus = problemStatus
        self.query = query
        self.size = size
    }
}
