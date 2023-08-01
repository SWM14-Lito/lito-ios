//
//  SearchedProblemsQueryDTO.swift
//  Domain
//
//  Created by 김동락 on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct SearchedProblemsQueryDTO {
    public let query: String
    public let page: Int
    public let size: Int
    
    public init(query: String, page: Int, size: Int) {
        self.query = query
        self.page = page
        self.size = size
    }
}
