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
    @StateObject private var cellViewModel: ProblemCellViewModel
    
    public init(viewModel: LearningHomeViewModel, cellViewModel: ProblemCellViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._cellViewModel = StateObject(wrappedValue: cellViewModel)
    }
    
    public var body: some View {
        VStack {
            profileView()
            startLearningButtonView()
            Divider()
            symbolExplanationView()
            problemListView()
        }

    }
    
    // 프로필 이미지와 닉네임 보여주는 뷰
    @ViewBuilder
    private func profileView() -> some View {
        VStack {
            Image(systemName: SymbolName.defaultProfile)
                .resizable()
                .frame(width: 88, height: 88)
                .clipShape(Circle())
            Text("Kristen")
                .font(.system(size: 13))
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
    
    // 문제 리스트 보여주는 뷰
    @ViewBuilder
    private func problemListView() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("풀던 문제")
                    .font(.system(size: 20, weight: .bold))
                ProblemCellView(solvedStatus: .solving, title: "제목제목제목", category: "운체운체", likedStatus: .liked) {
                    cellViewModel.moveToProblemView(id: 1)
                } likedAction: {
                    cellViewModel.changeLikedStatus(id: 1)
                }
            }
            .padding([.leading, .trailing], 20)
            VStack(alignment: .leading) {
                Text("추천 문제")
                    .font(.system(size: 20, weight: .bold))
                ProblemCellView(solvedStatus: .unsolved, title: "제목제목제목", category: "운체운체", likedStatus: .liked) {
                    cellViewModel.moveToProblemView(id: 2)
                } likedAction: {
                    cellViewModel.changeLikedStatus(id: 2)
                }
                ProblemCellView(solvedStatus: .unsolved, title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", category: "운체운체", likedStatus: .liked) {
                    cellViewModel.moveToProblemView(id: 3)
                } likedAction: {
                    cellViewModel.changeLikedStatus(id: 3)
                }
                ProblemCellView(solvedStatus: .unsolved, title: "제목제목제목", category: "운체운체운체운체운체운체운체운체운체운체운체운체운체운체운체운체운체운체", likedStatus: .liked) {
                    cellViewModel.moveToProblemView(id: 4)
                } likedAction: {
                    cellViewModel.changeLikedStatus(id: 4)
                }
            }
            .padding([.leading, .trailing], 20)
        }
    }
}
