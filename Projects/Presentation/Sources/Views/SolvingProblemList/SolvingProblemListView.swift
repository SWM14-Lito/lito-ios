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
        VStack(spacing: 0) {
            errorMessage
            problemList
        }
        .modifier(CustomNavigation(
            title: "풀던 문제",
            back: viewModel.back))
        .onAppear {
            viewModel.updateProblems()
        }
    }
    
    // 문제 리스트
    @ViewBuilder
    private var problemList: some View {
        if !viewModel.isLoading {
            VStack {
                if !viewModel.problemCellList.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach($viewModel.problemCellList, id: \.self) { problemCellVO in
                                ProblemCellView(problemCellVO: problemCellVO, problemCellHandling: viewModel)
                                    .onAppear {
                                        viewModel.getProblemList(problemUserId: problemCellVO.wrappedValue.problemUserId)
                                    }
                            }
                        }
                        .padding(20)
                        
                    }
                } else {
                    NoContentView(message: "풀던 문제가 없습니다.")
                }
            }
            .onAppear {
                viewModel.getProblemList()
            }
        } else {
            LoadingView()
        }
    }
    
    // API 에러 발생시 알려줌
    @ViewBuilder
    private var errorMessage: some View {
        ErrorView(errorObject: viewModel.errorObject)
    }
}
