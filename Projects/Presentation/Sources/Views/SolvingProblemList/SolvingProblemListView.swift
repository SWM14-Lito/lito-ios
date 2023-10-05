//
//  SolvingProblemView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct SolvingProblemListView: View {
    @StateObject private var viewModel: SolvingProblemListViewModel
    
    public init(viewModel: SolvingProblemListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                problemList
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .modifier(CustomNavigation(
            title: StringLiteral.solvingProblemListViewNavigationTitle,
            back: viewModel.back,
            disabled: viewModel.presentErrorAlert))
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
        .onAppear {
            viewModel.onScreenAppeared()
        }
    }
    
    // 문제 리스트
    @ViewBuilder
    private var problemList: some View {
        VStack {
            if !viewModel.problemCellList.isEmpty {
                ScrollView {
                    LazyVStack {
                        ForEach($viewModel.problemCellList, id: \.self) { problemCellVO in
                            ProblemCellView(problemCellVO: problemCellVO, problemCellHandling: viewModel)
                                .onAppear {
                                    viewModel.onProblemCellAppeared(id: problemCellVO.wrappedValue.problemUserId)
                                }
                        }
                    }
                    .padding(20)
                    
                }
            } else {
                NoContentView(message: StringLiteral.noSolvingProblemListMessage)
            }
        }
        .onAppear {
            viewModel.onProblemListAppeared()
        }
    }
}
