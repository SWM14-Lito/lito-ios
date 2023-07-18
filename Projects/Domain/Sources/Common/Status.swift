//
//  Status.swift
//  Domain
//
//  Created by 김동락 on 2023/07/18.
//  Copyright © 2023 com.lito. All rights reserved.
//

public enum ProblemSolvedStatus {
    case solved
    case unsolved
    case solving
    case unknown
    
    public init(rawValue: String?) {
        switch rawValue {
        case "풀이완료":
            self = .solved
        case "풀지않음":
            self = .unsolved
        case "풀이중":
            self = .solving
        default:
            self = .unknown
        }
    }
}

public enum ProblemFavoriteStatus {
    case favorite
    case notFavorite
    case unknown
    
    public init(isFavorite: Bool?) {
        switch isFavorite {
        case true:
            self = .favorite
        case false:
            self = .notFavorite
        default:
            self = .unknown
        }
    }
}
