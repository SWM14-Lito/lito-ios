//
//  ReviewNoteRequestDTO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct WrongProblemQueryDTO {
    public let page: Int
    public let size: Int
    
    public init(page: Int, size: Int) {
        self.page = page
        self.size = size
    }
}
