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
        VStack {
            Divider()
            headFilter
            filter
            problemList
            Spacer()
        }.navigationTitle(viewModel.selectedSubject.name)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.moveToProblemSearchScene()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.orange)
                    })
                }
            }
            .onAppear {
                viewModel.getProblemMutable()
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
    
}
