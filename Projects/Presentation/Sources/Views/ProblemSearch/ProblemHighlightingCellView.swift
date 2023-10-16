//
//  ProblemCellHighlightingView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain

// 문제 셀
struct ProblemHighlightingCellView<T: ProblemCell>: View {
    
    @Binding private var problemCellVO: T
    private let problemCellHandling: ProblemCellHandling
    private let highlighting: String
    
    init(problemCellVO: Binding<T>, problemCellHandling: ProblemCellHandling, highlighting: String) {
        self._problemCellVO = problemCellVO
        self.problemCellHandling = problemCellHandling
        self.highlighting = highlighting
    }
    
    private var highlightedQuestion: AttributedString {
        var highlightedQuestion = AttributedString(problemCellVO.question)
        highlightedQuestion.font = .Body2Regular
        highlightedQuestion.foregroundColor = .Text_Default
        if let range = highlightedQuestion.range(of: highlighting, options: .caseInsensitive) {
            highlightedQuestion[range].font = .Body2SemiBold
            highlightedQuestion[range].foregroundColor = .Text_Point
            if case .solved = problemCellVO.problemStatus {
                highlightedQuestion[range].backgroundColor = .Text_Highlight
            } else {
                highlightedQuestion[range].backgroundColor = .Text_Highlight_Light
            }
        }

        return highlightedQuestion
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
                            Text(problemCellVO.subjectName)
                                .font(.InfoRegular)
                                .foregroundColor(.Text_Info)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Text(highlightedQuestion)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
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
                .stroke(problemCellVO.problemStatus == .solved ? .Border_Serve : .Border_Default, lineWidth: 1)
        )
    }
    
}
