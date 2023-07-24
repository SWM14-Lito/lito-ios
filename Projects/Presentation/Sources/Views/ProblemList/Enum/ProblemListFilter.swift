//
//  ProblemListFilter.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public enum ProblemListFilter: CaseIterable {
    case all
    case unsolved
    case solved
    
    public var name: String {
        switch self {
        case .all:
            return "전체"
        case .unsolved:
            return "풀지않음"
        case .solved:
            return "풀이완료"
        }
    }
    
    public var number: Int {
        switch self {
        case .all:
            return 0
        case .unsolved:
            return 1
        case .solved:
            return 2
        }
    }
    
}
