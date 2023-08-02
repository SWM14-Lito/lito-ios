//
//  HeadSectionView.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct HeadSectionView<T: FilterComponent>: View {
    
    @Binding var selectedSubject: T
    @Namespace private var subjectAnimation
    private let filterHandling: FilterHandling
    
    init(selectedSubject: Binding<T>, filterHandling: FilterHandling) {
        self._selectedSubject = selectedSubject
        self.filterHandling = filterHandling
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack(spacing: 0) {
                HStack {
                    ForEach(T.allCases, id: \.self) { subject in
                        VStack {
                            Text(subject.name)
                                .lineLimit(1)
                                .fixedSize()
                                .font(.title3)
                                .frame(maxWidth: .infinity, minHeight: 30)
                                .foregroundColor(selectedSubject == subject ? .orange : .gray)
                            if selectedSubject == subject {
                                Capsule()
                                    .foregroundColor(.orange)
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "all", in: subjectAnimation)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                changeSubject(subject: subject)
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

extension HeadSectionView {
    private func changeSubject(subject: T) {
        if selectedSubject != subject {
            selectedSubject = subject
        }
    }
}
