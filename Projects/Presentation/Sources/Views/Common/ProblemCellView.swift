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
    func onProblemCellClicked(id: Int)
    func onFavoriteClicked(id: Int)
}

// 문제 셀
struct ProblemCellView<T: ProblemCell>: View {
    
    @Binding private var problemCellVO: T
    private let problemCellHandling: ProblemCellHandling
    
    private let unsolvedCnt: Int?
    
    init(problemCellVO: Binding<T>, problemCellHandling: ProblemCellHandling, unsolvedCnt: Int? = nil) {
        self._problemCellVO = problemCellVO
        self.problemCellHandling = problemCellHandling
        self.unsolvedCnt = unsolvedCnt
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
                Button {
                    problemCellHandling.onProblemCellClicked(id: problemCellVO.problemId)
                } label: {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: problemCellVO.problemStatus.symbolName)
                            .foregroundColor(problemCellVO.problemStatus == .solved ? .Button_Point : .Text_Serve)
                            .font(.system(size: 14))
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text(problemCellVO.subjectName)
                                    .font(.InfoRegular)
                                    .foregroundColor(.Text_Info)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                Spacer()
                                if let cnt = unsolvedCnt {
                                    Text("틀린 횟수: \(cnt)")
                                        .font(.InfoRegular)
                                        .foregroundColor(.Text_Point_Red)
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(1)
                                }
                            }
                            Text(problemCellVO.question)
                                .font(.Body2Regular)
                                .foregroundColor(.Text_Default)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                        }
                        Spacer()
                    }
                    .padding(.trailing, 46)
                }
                
                Button {
                    problemCellHandling.onFavoriteClicked(id: problemCellVO.problemId)
                } label: {
                    Circle()
                        .foregroundColor(problemCellVO.favorite == .favorite ? .Heart_Clicked_Inner : .Heart_Unclicked_Inner)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: problemCellVO.favorite.symbolName)
                                .font(.system(size: 28))
                                .foregroundColor(problemCellVO.favorite == .favorite ? .Heart_Clicked_Outer : .Heart_Unclicked_Outer)
                        )
                }
                .buttonStyle(.plain)

            }
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 18)
        .background(
            RoundedRectangle(cornerRadius: 16 )
                .fill(problemCellVO.problemStatus == .solved ? .Bg_Soft_Blue : .Bg_Default)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(problemCellVO.problemStatus == .solved ? .Border_Serve : .Border_Default, lineWidth: 1)
        )
    }
}
