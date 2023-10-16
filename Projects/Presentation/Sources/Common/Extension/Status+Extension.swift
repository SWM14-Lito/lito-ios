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
            return SymbolName.checkmarkCircleFill
        case .unsolved:
            return SymbolName.bookClosedFill
        case .solving:
            return SymbolName.bookFill
        case .unknown:
            return SymbolName.questionMark
        }
    } 
}

extension ProblemFavoriteStatus: Symbol {
    var symbolName: String {
        switch self {
        case .favorite, .notFavorite:
            return SymbolName.heartCircleFill
        case .unknown:
            return SymbolName.questionMark
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
