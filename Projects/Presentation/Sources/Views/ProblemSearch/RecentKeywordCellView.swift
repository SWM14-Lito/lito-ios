//
//  RecentKeywordCellView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

protocol RecentKeywordCellHandling {
    func searchWithRecentKeyword(keyword: String, index: Int)
    func deleteRecentKeyword(index: Int)
}

// 문제 셀
struct RecentKeywordCellView: View {
    
    private let keyword: String
    private let index: Int
    private let recentKeywordCellHandling: RecentKeywordCellHandling
    
    public init(keyword: String, index: Int, recentKeywordCellHandling: RecentKeywordCellHandling) {
        self.keyword = keyword
        self.index = index
        self.recentKeywordCellHandling = recentKeywordCellHandling
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            Button {
                recentKeywordCellHandling.searchWithRecentKeyword(keyword: keyword, index: index)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: SymbolName.magnifyingglass)
                        .font(.system(size: 18))
                        .foregroundColor(.Text_Info)
                    Text(keyword)
                        .font(.Body2Regular)
                        .foregroundColor(.Text_Default)
                    Spacer()
                }
                .background(.white)
            }
            .buttonStyle(.plain)
            
            Button {
                recentKeywordCellHandling.deleteRecentKeyword(index: index)
            } label: {
                Image(systemName: SymbolName.xmark)
                    .font(.system(size: 16))
                    .foregroundColor(.Text_Info)
                    .padding(.leading)
            }
        }
        .padding(.vertical, 14)
        .background(.white)
    }
    
}
