//
//  ProblemCell.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct ProblemCell: View {
    
    private let solvedStatus: ProblemSolvedStatus
    private let title: String
    private let category: String
    private let likedStatus: ProblemLikedStatus
    
    init(solvedStatus: ProblemSolvedStatus, title: String, category: String, likedStatus: ProblemLikedStatus) {
        self.solvedStatus = solvedStatus
        self.title = title
        self.category = category
        self.likedStatus = likedStatus
    }
    
    var body: some View {
        HStack {
            Image(systemName: solvedStatus.symbolName)
            VStack {
                Text(title)
                Text(category)
            }
            Image(systemName: likedStatus.symbolName)
        }
    }
}
