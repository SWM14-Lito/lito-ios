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
            errorMessage
            profile
            startLearningButton
            Divider()
            solvingProblem
            Spacer()
        }
        .onAppear {
            viewModel.getProfileAndProblems()
        }

    }
    
    // API 에러 발생시 알려줌
    @ViewBuilder
    private var errorMessage: some View {
        ErrorView(errorObject: viewModel.errorObject)
    }
    
    // 프로필 이미지와 닉네임 보여주기
    @ViewBuilder
    private var profile: some View {
        VStack {
            if let userInfo = viewModel.userInfo {
                VStack {
                    UrlImageView(urlString: userInfo.profileImgUrl)
                        .frame(width: 88, height: 88)
                        .clipShape(Circle())
                    Text(userInfo.nickname)
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
    
    // 학습 시작 버튼
    @ViewBuilder
    private var startLearningButton: some View {
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
    
    // 풀던 문제 보여주기
    @ViewBuilder
    private var solvingProblem: some View {
        if let problemCellVO = $viewModel.solvingProblem.wrappedValue {
            VStack(alignment: .leading) {
                HStack {
                    Text("풀던 문제")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Button {
                        viewModel.moveToSolvingProblemView()
                    } label: {
                        Text("전체 보기")
                    }
                }
                
                ProblemCellView(problemCellVO: $viewModel.solvingProblem.toUnwrapped(), problemCellHandling: viewModel)
                
            }
            .padding([.leading, .trailing], 20)
        } else {
            Spacer()
            ProgressView()
        }
    }
}
