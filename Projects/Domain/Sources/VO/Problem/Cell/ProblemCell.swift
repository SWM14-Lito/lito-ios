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
    var problemStatus: ProblemSolvedStatus { get set }
    var favorite: ProblemFavoriteStatus { get set }
    var subjectName: String { get }
}
