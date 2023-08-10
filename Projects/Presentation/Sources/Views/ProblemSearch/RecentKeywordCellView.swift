//
//  RecentKeywordCellView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

// 문제 셀
struct RecentKeywordCellView: View {
    
    private let keyword: String
    
    public init(keyword: String) {
        self.keyword = keyword
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: SymbolName.magnifyingglass)
                .font(.system(size: 18))
                .foregroundColor(.Text_Info)
            Text(keyword)
                .font(.Body2Regular)
                .foregroundColor(.Text_Default)
            Spacer()
            Image(systemName: SymbolName.xmark)
                .font(.system(size: 16))
                .foregroundColor(.Text_Info)
        }
        .padding(.vertical, 14)
    }
    
}
