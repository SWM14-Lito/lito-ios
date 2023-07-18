//
//  LearningHomeView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct LearningHomeView: View {
    
    @StateObject private var viewModel: LearningHomeViewModel

    public init(viewModel: LearningHomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            errorView()
            profileView()
            startLearningButtonView()
            Divider()
            solvingProblemView()
            Spacer()
        }
        .onAppear {
            viewModel.getProfileAndProblems()
        }

    }
    
    // API 에러 보여주는 뷰
    @ViewBuilder
    private func errorView() -> some View {
        ErrorView(errorObject: viewModel.errorObject)
    }
    
    // 프로필 이미지와 닉네임 보여주는 뷰
    @ViewBuilder
    private func profileView() -> some View {
        VStack {
            if let learningHomeVO = viewModel.learningHomeVO {
                VStack {
                    UrlImageView(urlString: learningHomeVO.userInfo.profileImgUrl)
                        .frame(width: 88, height: 88)
                        .clipShape(Circle())
                    Text(learningHomeVO.userInfo.nickname)
                        .font(.system(size: 12))
                }
                .frame(height: 115)
            } else {
                ProgressView()
                    .frame(height: 115)
            }
        }
        .padding(.bottom, 18)
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
    
    // 풀던 문제 보여주는 뷰
    @ViewBuilder
    private func solvingProblemView() -> some View {
        if let learningHomeVO = viewModel.learningHomeVO {
            if let recommendedProblem = learningHomeVO.recommendedProblem {
                VStack(alignment: .leading) {
                    Text("풀던 문제")
                        .font(.system(size: 20, weight: .bold))
                    ProblemCellView(problemCellVO: recommendedProblem, viewModel: viewModel)
                }
                .padding([.leading, .trailing], 20)
            }
        } else {
            Spacer()
            ProgressView()
        }
    }
}
