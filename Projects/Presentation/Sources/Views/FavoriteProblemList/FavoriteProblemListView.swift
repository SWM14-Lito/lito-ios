//
//  FavoriteProblemListView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct FavoriteProblemListView: View {
    @StateObject private var viewModel: FavoriteProblemListViewModel
    @Namespace private var subjectAnimation
    
    public init(viewModel: FavoriteProblemListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
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
            if viewModel.isLoading {
                LoadingView()
            }
            errorMessage
        }
        .modifier(CustomNavigation(
            title: "찜한 문제",
            back: viewModel.back))
        .onAppear {
            viewModel.updateProblemValues()
        }
    }
    
    // 과목 필터링
    @ViewBuilder
    private var headFilter: some View {
        HeadFilterView(selectedFilter: $viewModel.selectedSubject, filterHandling: viewModel)
    }
    
    // 필터링
    @ViewBuilder
    private var filter: some View {
        FilterView(selectedFilters: $viewModel.selectedFilters, filterHandling: viewModel)
    }
    
    // 찜한 문제 리스트
    @ViewBuilder
    private var problemList: some View {
        VStack {
            if !viewModel.problemCellList.isEmpty {
                ScrollView {
                    LazyVStack {
                        ForEach($viewModel.problemCellList, id: \.self) { problemCellVO in
                            ProblemCellView(problemCellVO: problemCellVO, problemCellHandling: viewModel)
                                .onAppear {
                                    viewModel.getProblemList(problemFavoriteId: problemCellVO.wrappedValue.favoriteId)
                                }
                        }
                    }
                    .padding(20)
                }
            } else {
                NoContentView(message: "찜한 문제가 없습니다.")
            }
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
