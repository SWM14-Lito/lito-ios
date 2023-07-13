//
//  LearningHomeView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Kingfisher

public struct LearningHomeView: View {
    
    @StateObject private var viewModel: LearningHomeViewModel
    @StateObject private var cellViewModel: ProblemCellViewModel
    private var errorView = ErrorView()
    
    public init(viewModel: LearningHomeViewModel, cellViewModel: ProblemCellViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._cellViewModel = StateObject(wrappedValue: cellViewModel)
        self.errorView.errorObject = viewModel.errorObject
    }
    
    public var body: some View {
        VStack {
            errorView
            profileView()
            startLearningButtonView()
            Divider()
            symbolExplanationView()
            solvingProblemView()
        }

    }
    
    // 프로필 이미지와 닉네임 보여주는 뷰
    @ViewBuilder
    private func profileView() -> some View {
        if let learningHomeVO = viewModel.learningHomeVO {
            VStack {
                if let urlString = learningHomeVO.userInfo.profileImgUrl,
                   let url = URL(string: urlString) {
                    KFImage(url)
                        .resizable()
                        .frame(width: 88, height: 88)
                        .clipShape(Circle())
                } else {
                    Image(systemName: SymbolName.defaultProfile)
                        .resizable()
                        .frame(width: 88, height: 88)
                        .clipShape(Circle())
                }
                Text(learningHomeVO.userInfo.nickname)
                    .font(.system(size: 13))
            }
            .padding(.bottom, 18)
        }
    }
    
    // 학습 시작 버튼 뷰
    @ViewBuilder
    private func startLearningButtonView() -> some View {
        Button {
            viewModel.moveToLearningView()
        } label: {
            Text("학습 시작")
                .font(.system(size: 20))
                .padding([.leading, .trailing], 70)
                .padding([.top, .bottom], 10)
        }
        .buttonStyle(.bordered)
        .tint(.orange)
        .cornerRadius(35)
        .padding(.bottom, 20)
    }
    
    // 각 아이콘에 대한 설명 나타내는 뷰
    @ViewBuilder
    private func symbolExplanationView() -> some View {
        HStack {
            SymbolExplanationView(symbol: ProblemSolvedStatus.unsolved)
            SymbolExplanationView(symbol: ProblemSolvedStatus.solving)
            SymbolExplanationView(symbol: ProblemSolvedStatus.solved)
            Spacer()
        }
        .padding(.bottom, 20)
        .padding(.leading, 20)
    }
    
    // 풀던 문제 보여주는 뷰
    @ViewBuilder
    private func solvingProblemView() -> some View {
        if let recommendProblem = viewModel.learningHomeVO?.recommendedProblem {
            VStack(alignment: .leading) {
                Text("풀던 문제")
                    .font(.system(size: 20, weight: .bold))
                ProblemCellView(solvedStatus: .solving, title: "제목입니다.", category: recommendProblem.subject, favorite: .isFavorite) {
                    cellViewModel.moveToProblemView(id: recommendProblem.problemId)
                } favoriteAction: {
                    cellViewModel.changeFavoriteStatus(id: recommendProblem.problemId)
                }
            }
            .padding([.leading, .trailing], 20)
        }
    }
}
