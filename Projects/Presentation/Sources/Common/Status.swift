//
//  Icon.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

protocol Symbol {
    var symbolName: String { get }
}

protocol Explanation {
    var explanation: String { get }
}

enum ProblemSolvedStatus: Symbol, Explanation {
    case solved, unsolved, solving
    
    var symbolName: String {
        switch self {
        case .solved:
            return SymbolName.solved
        case .unsolved:
            return SymbolName.unsolved
        case .solving:
            return SymbolName.solving
        }
    }
    
    var explanation: String {
        switch self {
        case .solved:
            return "풀이완료"
        case .unsolved:
            return "풀지않음"
        case .solving:
            return "풀이중"
        }
    }
}

enum ProblemLikedStatus: Symbol {
    case liked, unliked
    
    var symbolName: String {
        switch self {
        case .liked:
            return SymbolName.liked
        case .unliked:
            return SymbolName.unliked
        }
    }
}
