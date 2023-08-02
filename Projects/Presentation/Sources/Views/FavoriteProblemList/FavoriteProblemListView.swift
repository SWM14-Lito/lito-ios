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
        VStack {
            Divider()
            headSection
            filter
            problemList
            Spacer()
        }.navigationTitle(viewModel.selectedSubject.name)
            .navigationBarTitleDisplayMode(.large)
    }
    
    // 필터링
    @ViewBuilder
    private var filter: some View {
        VStack {
            FilterView(selectedFilters: $viewModel.selectedFilters, filterHandling: viewModel)
            Divider()
        }
    }
    
    // 과목 선택 헤더
    @ViewBuilder
    private var headSection: some View {
        ScrollView(.horizontal) {
            VStack(spacing: 0) {
                HStack {
                    ForEach(SubjectInfo.allCases, id: \.self) { subject in
                        VStack {
                            Text(subject.name)
                                .lineLimit(1)
                                .fixedSize()
                                .font(.title3)
                                .frame(maxWidth: .infinity, minHeight: 30)
                                .foregroundColor(viewModel.selectedSubject == subject ? .orange : .gray)
                            if viewModel.selectedSubject == subject {
                                Capsule()
                                    .foregroundColor(.orange)
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "all", in: subjectAnimation)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.changeSubject(subject: subject)
                            }
                        }
                    }.padding(.leading, 10)
                }
                Divider()
            }
        }
        .scrollIndicators(.never)
    }
    
    // 찜한 문제 리스트
    @ViewBuilder
    private var problemList: some View {
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
