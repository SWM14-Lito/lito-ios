//
//  QuestionListView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct QuestionListView: View {
    
    @StateObject private var viewModel: QuestionListViewModel
    @Namespace private var subjectAnimation
    
    public init(viewModel: QuestionListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            Divider()
            ScrollView(.horizontal) {
                headSection()
            }
            .scrollIndicators(.never)
            ScrollView {
                Text("test")
                Text("test")
                Text("test")
            }
            Spacer()
        }.navigationTitle("학습")
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
    private func headSection() -> some View {
            VStack(spacing: 0) {
                HStack {
                    ForEach(QuestionListViewModel.SubjectInfo.allCases, id: \.self) { subject in
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
    
}
