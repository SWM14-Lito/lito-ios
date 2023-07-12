//
//  ProblemCell.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct ProblemCellView: View {
    
    private let solvedStatus: ProblemSolvedStatus
    private let title: String
    private let category: String
    private let likedStatus: ProblemLikedStatus
    private let buttonAction: () -> Void
    private let likedAction: () -> Void
    
    init(solvedStatus: ProblemSolvedStatus, title: String, category: String, likedStatus: ProblemLikedStatus, buttonAction: @escaping () -> Void, likedAction: @escaping () -> Void) {
        self.solvedStatus = solvedStatus
        self.title = title
        self.category = category
        self.likedStatus = likedStatus
        self.buttonAction = buttonAction
        self.likedAction = likedAction
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Button {
                buttonAction()
            } label: {
                HStack {
                    Image(systemName: solvedStatus.symbolName)
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 15))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                        Text(category)
                            .font(.system(size: 13))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding(.trailing, 15)
            }
            
            Button {
                likedAction()
            } label: {
                    Image(systemName: likedStatus.symbolName)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}
