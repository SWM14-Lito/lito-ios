//
//  ProblemCell.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ProblemCellView: View {
    
    @StateObject private var viewModel: ProblemCellViewModel
    
    public init(viewModel: ProblemCellViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        if let problemCellVO = viewModel.problemCellVO {
            ZStack(alignment: .trailing) {
                Button {
                    viewModel.moveToProblemView(id: problemCellVO.problemId)
                } label: {
                    HStack {
                        Image(systemName: ProblemSolvedStatus(rawValue: problemCellVO.solved)!.symbolName)
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
                    Image(systemName: ProblemFavoriteStatus(isFavorite: problemCellVO.favorite).symbolName)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }
}
