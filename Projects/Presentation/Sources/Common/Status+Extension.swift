//
//  Icon.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

protocol Symbol {
    var symbolName: String { get }
}

extension ProblemSolvedStatus: Symbol {
    var symbolName: String {
        switch self {
        case .solved:
            return SymbolName.solved
        case .unsolved:
            return SymbolName.unsolved
        case .solving:
            return SymbolName.solving
        case .unknown:
            return SymbolName.unknown
        }
    } 
}

extension ProblemFavoriteStatus: Symbol {
    var symbolName: String {
        switch self {
        case .favorite:
            return SymbolName.favorite
        case .notFavorite:
            return SymbolName.notFavorite
        case .unknown:
            return SymbolName.unknown
        }
    }
    
    mutating func toggle() {
        if self == .favorite {
            self = .notFavorite
        } else if self == .notFavorite {
            self = .favorite
        }
    }
}
