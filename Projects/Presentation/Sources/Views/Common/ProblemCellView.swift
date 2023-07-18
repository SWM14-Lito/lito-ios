//
//  ProblemCell.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain

public protocol ProblemCellHandling {
    func moveToProblemView(id: Int)
    func changeFavoriteStatus(id: Int)
}

public struct ProblemCellView: View {
    
    private let problemCellVO: ProblemCellVO
    private let viewModel: ProblemCellHandling
    
    public init(problemCellVO: ProblemCellVO, viewModel: ProblemCellHandling) {
        self.problemCellVO = problemCellVO
        self.viewModel = viewModel
    }
    
    public var body: some View {
            ZStack(alignment: .trailing) {
                Button {
                    viewModel.moveToProblemView(id: problemCellVO.problemId)
                } label: {
                    HStack {
                        Image(systemName: problemCellVO.solved.symbolName)
                        VStack(alignment: .leading) {
                            Text(problemCellVO.question)
                                .font(.system(size: 15))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                            Text(problemCellVO.subject)
                                .font(.system(size: 13))
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    .padding(.trailing, 15)
                }
                
                Button {
                    viewModel.changeFavoriteStatus(id: problemCellVO.problemId)
                } label: {
                    Image(systemName: problemCellVO.favorite.symbolName)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 1)
            )
        
    }
}
