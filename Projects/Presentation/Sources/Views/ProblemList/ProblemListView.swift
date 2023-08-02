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
            headSection
            filteringView
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
    }
    
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
    
    // TODO: 여러개의 filter 요소를 받아서 동적으로 생성하도록 공통 컴포넌트화 필요
    @ViewBuilder
    private var filteringView: some View {
        ScrollView(.horizontal) {
            VStack {
                HStack {
                    Button {
                        viewModel.filterSheetToggle()
                    } label: {
                        HStack {
                            Text("필터")
                            Image(systemName: SymbolName.arrowtriangleDown)
                        }
                    }
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10   )
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .sheet(isPresented: $viewModel.showFilterSheet) {
                        filteringModal
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                            .frame(alignment: .topTrailing)
                    }
                    // 동적으로 선택된 필터 박스 생성.
                    ForEach(viewModel.selectedFilters, id: \.self) { filter in
                        if filter != .all {
                            Button(filter.name) {
                                viewModel.removeFilter(filter)
                            }
                            .font(.caption)
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                    }
                }
            }
            .padding(.leading)
        }.scrollIndicators(.never)
    }
    
    @ViewBuilder
    private var filteringModal: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 20) {
                Text("풀이 여부")
                    .font(.title2)
                HStack {
                    ForEach(ProblemListFilter.allCases, id: \.self) { filter in
                        Button(filter.name) {
                            viewModel.selectFilter(filter)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(viewModel.selectedFilter == filter ? .orange : .gray)
                    }
                }
            }
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Button("초기화") {
                    viewModel.selectedFilter = .all
                }
                .buttonStyle(.bordered)
                .font(.title2)
                Spacer()
                Button("적용하기") {
                    viewModel.applyFilter()
                }
                .buttonStyle(.bordered)
                .font(.title2)
                Spacer()
            }
        }
        .padding(20)
        .onAppear {
            viewModel.storePrevFilter()
        }
        .onDisappear {
            viewModel.cancelSelectedFilter()
        }
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
