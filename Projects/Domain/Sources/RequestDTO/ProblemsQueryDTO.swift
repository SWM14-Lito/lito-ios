//
//  ProblemsQueryDTO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct ProblemsQueryDTO {
    public let subjectId: Int?
    public let problemStatus: String?
    public let query: String?
    public let page: Int
    public let size: Int
    
    public init(subjectId: Int?, problemStatus: String?, query: String? = nil, page: Int = 0, size: Int = 10) {
        self.subjectId = subjectId
        self.problemStatus = problemStatus
        self.query = query
        self.page = page
        self.size = size
    }
    
}
