//
//  QuestionListView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ProblemListView: View {
    
    @StateObject private var viewModel: ProblemListViewModel
    @Namespace private var subjectAnimation
    
    public init(viewModel: ProblemListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            errorMessage
            headFilter
                .padding([.top, .leading], 20)
            Divider()
            VStack(spacing: 0) {
                filter
                    .padding(.top, 20)
                problemList
                Spacer()
            }
            .background(.Bg_Light)
        }
        .modifier(CustomNavigation(
            title: viewModel.selectedSubject.name,
            back: viewModel.back,
            toolbarContent: SymbolButtonToolbar(
                placement: .navigationBarTrailing,
                symbolName: SymbolName.magnifyingglass,
                action: viewModel.moveToProblemSearchScene)))
        .onAppear {
            viewModel.updateProblems()
        }
    }
    
    @ViewBuilder
    private var headFilter: some View {
        HeadFilterView(selectedFilter: $viewModel.selectedSubject, filterHandling: viewModel)
    }
    
    @ViewBuilder
    private var filter: some View {
        FilterView(selectedFilters: $viewModel.selectedFilters, filterHandling: viewModel)
    }
    
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
        .onAppear {
            viewModel.getProblemList()
        }
    }
    
    // API 에러 발생시 알려줌
    @ViewBuilder
    private var errorMessage: some View {
        ErrorView(errorObject: viewModel.errorObject)
    }
}
