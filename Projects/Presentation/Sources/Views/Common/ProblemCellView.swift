//
//  ProblemCell.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain

// 문제 셀 사용하는 ViewModel에서 해당 프로토콜 따르도록 해야함
protocol ProblemCellHandling {
    func moveToProblemView(id: Int)
    func changeFavoriteStatus(id: Int)
}

// 문제 셀
struct ProblemCellView<T: ProblemCell>: View {
    
    @Binding private var problemCellVO: T
    private let problemCellHandling: ProblemCellHandling
    
    init(problemCellVO: Binding<T>, problemCellHandling: ProblemCellHandling) {
        self._problemCellVO = problemCellVO
        self.problemCellHandling = problemCellHandling
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
                Button {
                    problemCellHandling.moveToProblemView(id: problemCellVO.problemId)
                } label: {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: problemCellVO.problemStatus.symbolName)
                            .foregroundColor(problemCellVO.problemStatus == .solved ? Color.theme.Button_Point : Color.theme.Text_Serve)
                            .font(.system(size: 14))
                        VStack(alignment: .leading, spacing: 2) {
                            Text(problemCellVO.subjectName)
                                .font(.system(size: 12))
                                .foregroundColor(Color.theme.Text_Info)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Text(problemCellVO.question)
                                .font(.system(size: 14))
                                .foregroundColor(Color.theme.Text_Default)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                        }
                        Spacer()
                    }
                    .padding(.trailing, 46)
                }
                
                Button {
                    problemCellHandling.changeFavoriteStatus(id: problemCellVO.problemId)
                } label: {
                    Circle()
                        .foregroundColor(problemCellVO.favorite == .favorite ? Color.theme.Heart_Clicked_Inner : Color.theme.Heart_Unclicked_Inner)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: problemCellVO.favorite.symbolName)
                                .font(.system(size: 28))
                                .foregroundColor(problemCellVO.favorite == .favorite ? Color.theme.Heart_Clicked_Outer : Color.theme.Heart_Unclicked_Outer)
                        )
                }
                .buttonStyle(.plain)

            }
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 18)
        .background(problemCellVO.problemStatus == .solved ? Color.theme.Fill_Soft_Blue : Color.theme.Bg_Default)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(problemCellVO.problemStatus == .solved ? Color.theme.Border_Serve : Color.theme.Border_Default, lineWidth: 1)
        )
    }
}
