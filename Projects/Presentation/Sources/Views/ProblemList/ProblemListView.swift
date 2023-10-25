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
        ZStack {
            VStack(spacing: 0) {
                headFilter
                    .padding([.top, .leading, .trailing], 20)
                Divider()
                VStack(spacing: 0) {
                    filter
                        .padding(.top, 20)
                    problemList
                    Spacer()
                }
                .background(.Bg_Light)
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .modifier(CustomNavigation(
            title: viewModel.selectedSubject.name,
            back: viewModel.back,
            toolbarContent: SymbolButtonToolbar(
                placement: .navigationBarTrailing,
                symbolName: SymbolName.magnifyingglass,
                action: viewModel.onSearchButtonClicked),
            disabled: viewModel.presentErrorAlert))
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
        .onAppear {
            viewModel.onScreenAppeared()
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
        VStack {
            if !viewModel.problemCellList.isEmpty {
                ScrollView {
                    LazyVStack {
                        ForEach($viewModel.problemCellList, id: \.self) { problemCellVO in
                            ProblemCellView(problemCellVO: problemCellVO, problemCellHandling: viewModel)
                                .onAppear {
                                    viewModel.onProblemCellAppeared(id: problemCellVO.wrappedValue.problemId)
                                }
                        }
                    }
                    .padding(20)
                }
            } else {
                NoContentView(message: StringLiteral.noProblemListMessage)
            }
        }
        .onAppear {
            viewModel.onProblemListAppeared()
        }
    }
}
