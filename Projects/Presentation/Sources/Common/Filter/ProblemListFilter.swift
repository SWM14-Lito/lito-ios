//
//  ProblemListFilter.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public enum ProblemListFilter: FilterComponent {
    
    typealias T = Self
    
    case all
    case unsolved
    case solved
    
    static var defaultValue: ProblemListFilter {
        return .all
    }
    
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
    
    public var query: String {
        switch self {
        case .all:
            return ""
        case .unsolved:
            return "PROCESS"
        case .solved:
            return "COMPLETE"
        }
    }
    
}
