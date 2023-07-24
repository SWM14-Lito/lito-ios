//
//  SubjectInfo.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public enum SubjectInfo: String, CaseIterable {
    case all
    case operationSystem
    case network
    case database
    case structure
    
    public var name: String {
        switch self {
        case .all:
            return "전체"
        case .operationSystem:
            return "운영체제"
        case .network:
            return "네트워크"
        case .database:
            return "데이터베이스"
        case .structure:
            return "자료구조"
        }
    }
    
    public var number: Int {
        switch self {
        case .all:
            return 0
        case .operationSystem:
            return 1
        case .network:
            return 2
        case .database:
            return 3
        case .structure:
            return 4
        }
    }
}
