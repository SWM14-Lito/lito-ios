//
//  HeadSectionView.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

// 헤더쪽에 있는 필터
struct HeadFilterView<T: FilterComponent>: View {
    
    @Binding var selectedFilter: T
    @Namespace private var subjectAnimation
    private let filterHandling: FilterHandling
    
    init(selectedFilter: Binding<T>, filterHandling: FilterHandling) {
        self._selectedFilter = selectedFilter
        self.filterHandling = filterHandling
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack(spacing: 0) {
                HStack {
                    ForEach(T.allCases, id: \.self) { filter in
                        VStack {
                            Text(filter.name)
                                .lineLimit(1)
                                .fixedSize()
                                .font(.title3)
                                .frame(maxWidth: .infinity, minHeight: 30)
                                .foregroundColor(selectedFilter == filter ? .Button_Point : .Text_Serve)
                            if selectedFilter == filter {
                                Capsule()
                                    .foregroundColor(.orange)
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "all", in: subjectAnimation)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                changeFilter(filter: filter)
                                filterHandling.updateProblem()
                            }
                        }
                    }.padding(.leading, 10)
                }
                Divider()
            }
        }
        .scrollIndicators(.never)
    }
}

extension HeadFilterView {
    // 필터 선택하기
    private func changeFilter(filter: T) {
        if selectedFilter != filter {
            selectedFilter = filter
        }
    }
}
