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
    @FocusState private var focused: Bool 
    
    public init(viewModel: ProblemSearchViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            searchBox
                .padding(.top, 15)
            VStack(spacing: 0) {
                Divider()
                    .foregroundColor(.Divider_Default)
                    .padding(.top, 14)
                searchResult
            }
            Spacer()
        }
        .background(Color.white)
        .onTapGesture {
            focused = false
        }
        .modifier(CustomNavigation(
            title: StringLiteral.problemSearchViewNavigationTitle,
            back: viewModel.back,
            disabled: viewModel.presentErrorAlert))
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
        .onAppear {
            viewModel.onScreenAppeared()
        }
    }
    
    // 검색어 입력 박스
    @ViewBuilder
    private var searchBox: some View {
        HStack(spacing: 0) {
            TextField(StringLiteral.searchFieldPlaceHolder, text: $viewModel.searchKeyword)
                .font(.Body2Regular)
                .onSubmit {
                    viewModel.onSearchKeywordSubmitted()
                }
                .focused($focused)
                .padding(.leading, 18)
            HStack(spacing: 13) {
                if viewModel.searchKeyword.count != 0 {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            viewModel.searchRemoveButtonClicked()
                        }
                }
                Button {
                    viewModel.onSearchKeywordSubmitted()
                } label: {
                    Image(systemName: SymbolName.magnifyingglass)
                        .font(.system(size: 20))
                        .foregroundColor(.Text_Default)
                        .padding(.trailing, 18)
                }
            }
            .padding(.vertical, 11)
        }
        .background(
            RoundedRectangle(cornerRadius: 46 )
                .fill(.Bg_Deep)
        )
        .padding(.horizontal, 20)

    }
    
    // 검색 결과 (상태에 따라 각각 다른 뷰 보여주기)
    @ViewBuilder
    private var searchResult: some View {
        switch viewModel.searchState {
        case .notStart:
            recentSearched
        case .waiting:
            LoadingView()
        case .finish:
            if viewModel.problemCellList.isEmpty {
                NoContentView(message: StringLiteral.noSearchContentMessage)
            } else {
                problemList
                    .background(.Bg_Light)
            }
        }
    }
    
    // 최근 검색
    @ViewBuilder
    private var recentSearched: some View {
        VStack(spacing: 10) {
            HStack {
                Text(StringLiteral.recentKeywordTitle)
                    .font(.Body1SemiBold)
                Spacer()
                Button {
                    viewModel.removeRecentKeywords()
                } label: {
                    Text(StringLiteral.deleteAllRecentKeywordButtonTitle)
                        .font(.Body3Regular)
                        .foregroundColor(.Text_Info)
                        .underline()
                }
            }
            ScrollView {
                ForEach(viewModel.recentKeywords.reversed().indices, id: \.self) { idx in
                    RecentKeywordCellView(keyword: viewModel.recentKeywords.reversed()[idx], index: viewModel.recentKeywords.count - idx - 1, recentKeywordCellHandling: viewModel)
                }
            }
        }
        .padding(20)
    }
    
    // 문제 리스트
    @ViewBuilder
    private var problemList: some View {
        ScrollView {
            LazyVStack {
                HStack(spacing: 0) {
                    Text("‘\(viewModel.searchedKeyword)‘ " + StringLiteral.searchResultCountMessage1)
                    if let problemTotalSize = viewModel.problemTotalSize {
                        Text(String(problemTotalSize))
                            .foregroundColor(.Text_Point)
                    }
                    Text(StringLiteral.searchResultCountMessage2)
                    Spacer()
                }
                .font(.Body2Regular)
                ForEach($viewModel.problemCellList, id: \.self) { problemCellVO in
                    ProblemHighlightingCellView(problemCellVO: problemCellVO, problemCellHandling: viewModel, highlighting: viewModel.searchedKeyword)
                        .onAppear {
                            viewModel.onProblemCellAppeared(id: problemCellVO.wrappedValue.problemId)
                        }
                }
            }
            .padding(20)
        }
    }
}
