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

public struct ProblemCellView<T: ProblemCell>: View {
    
    @Binding private var problemCellVO: T
    private let problemCellHandling: ProblemCellHandling
    
    public init(problemCellVO: Binding<T>, problemCellHandling: ProblemCellHandling) {
        self._problemCellVO = problemCellVO
        self.problemCellHandling = problemCellHandling
    }
    
    public var body: some View {
            ZStack(alignment: .trailing) {
                Button {
                    problemCellHandling.moveToProblemView(id: problemCellVO.problemId)
                } label: {
                    HStack {
                        Image(systemName: problemCellVO.problemStatus.symbolName)
                        VStack(alignment: .leading) {
                            Text(problemCellVO.question)
                                .font(.system(size: 15))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                            Text(problemCellVO.subjectName)
                                .font(.system(size: 13))
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    .padding(.trailing, 15)
                }
                
                Button {
                    problemCellHandling.changeFavoriteStatus(id: problemCellVO.problemId)
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
