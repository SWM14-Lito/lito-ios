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
            ScrollView {
                Text("test")
                Text("test")
                Text("test")
            }
            Spacer()
        }.navigationTitle(viewModel.selectedSubject.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add your button action here
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
                    ForEach(ProblemListViewModel.SubjectInfo.allCases, id: \.self) { subject in
                        VStack {
                            Text(subject.rawValue)
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
                                viewModel.selectedSubject = subject
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
                        filteringModal(viewModel: viewModel)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                            .frame(alignment: .topTrailing)
                    }
                    // 동적으로 선택된 필터 박스 생성.
                    ForEach(viewModel.selectedFilters, id: \.self) { filter in
                        if filter != .all {
                            Button(filter.rawValue) {
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
    
    private struct filteringModal: View {
        
        @StateObject private var viewModel: ProblemListViewModel
        
        public init(viewModel: ProblemListViewModel) {
            self._viewModel = StateObject(wrappedValue: viewModel)
        }
        
        public var body: some View {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("풀이 여부")
                        .font(.title2)
                    HStack {
                        ForEach(ProblemListViewModel.ProblemListFilter.allCases, id: \.self) { filter in
                            Button(filter.rawValue) {
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
    }
    
}
