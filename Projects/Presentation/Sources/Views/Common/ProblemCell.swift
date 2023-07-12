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
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                Text(category)
                    .font(.system(size: 13))
                    .foregroundColor(Color.gray)
            }
            Spacer()
            Image(systemName: likedStatus.symbolName)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}
