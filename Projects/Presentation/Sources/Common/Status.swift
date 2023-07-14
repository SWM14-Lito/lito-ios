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

enum ProblemSolvedStatus: String, Symbol, Explanation {
    case solved = "풀이완료"
    case unsolved = "풀지않음"
    case solving = "풀이중"
    
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
        return rawValue
    }
}

enum ProblemFavoriteStatus: Symbol {
    case isFavorite
    case isNotFavorite
    
    var symbolName: String {
        switch self {
        case .isFavorite:
            return SymbolName.isFavorite
        case .isNotFavorite:
            return SymbolName.isNotFavorite
        }
    }
    
    init(isFavorite: Bool) {
        if isFavorite {
            self = .isFavorite
        } else {
            self = .isNotFavorite
        }
    }
}
