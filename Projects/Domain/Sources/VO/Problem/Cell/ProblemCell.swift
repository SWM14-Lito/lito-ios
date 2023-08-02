//
//  ProblemCell.swift
//  Domain
//
//  Created by 김동락 on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

public protocol ProblemCell {
    var problemId: Int { get }
    var question: String { get }
    var problemStatus: ProblemSolvedStatus { get }
    var favorite: ProblemFavoriteStatus { get }
    var subjectName: String { get }
}
