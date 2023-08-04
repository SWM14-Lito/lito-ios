//
//  ProblemSearchView.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ProblemSearchView: View {
    
    @StateObject private var viewModel: ProblemSearchViewModel
    
    public init(viewModel: ProblemSearchViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            errorMessage
            searchBox
            Spacer()
            searchResult
            Spacer()
        }
        .onAppear {
            viewModel.getProblemMutable()
        }
    }
    
    // 검색어 입력 박스
    @ViewBuilder
    private var searchBox: some View {
        TextField("원하는 문제의 제목을 검색해보세요.", text: $viewModel.searchKeyword)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray)
            )
            .padding()
            .onSubmit {
                viewModel.resetProblemCellList()
                viewModel.getProblemList()
            }
    }
    
    // 검색 결과 (상태에 따라 각각 다른 뷰 보여주기)
    @ViewBuilder
    private var searchResult: some View {
        switch viewModel.searchState {
        case .notStart:
            EmptyView()
        case .waiting:
            ProgressView()
        case .finish:
            if viewModel.problemCellList.isEmpty {
                Text("검색 결과가 없습니다.")
            } else {
                problemList
            }
        }
    }
    
    // 문제 리스트
    @ViewBuilder
    private var problemList: some View {
        ScrollView {
            LazyVStack {
                ForEach($viewModel.problemCellList, id: \.self) { problemCellVO in
                    ProblemCellView(problemCellVO: problemCellVO, problemCellHandling: viewModel)
                        .onAppear {
                            viewModel.getProblemList(problemId: problemCellVO.wrappedValue.problemId)
                        }
                }
            }
            .padding(20)
        }
    }
    
    // API 에러 발생시 알려줌
    @ViewBuilder
    private var errorMessage: some View {
        ErrorView(errorObject: viewModel.errorObject)
    }
}
