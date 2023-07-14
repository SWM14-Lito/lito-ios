//
//  QuestionListView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct QuestionListView: View {
    
    @State private var selectedSubject: subjectInfo = .all
    @State private var selectedSolve: solveInfo = .unsolved
    @Namespace private var subjectAnimation
    
    public init() {}
    
    public var body: some View {
        VStack {
            Divider()
            ScrollView(.horizontal) {
                headSection()
            }
            .scrollIndicators(.never)
            Picker("solve", selection: $selectedSolve) {
                ForEach(solveInfo.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            Divider()
            HStack(spacing: 0) {
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(.orange)
                    Text("풀이중")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Image(systemName: "book.closed.fill")
                        .foregroundColor(.orange)
                    Text("풀지않음")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.orange)
                    Text("풀이완료")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
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
                    ForEach(subjectInfo.allCases, id: \.self) { subject in
                        VStack {
                            Text(subject.rawValue)
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
                                self.selectedSubject = subject
                            }
                        }
                    }.padding(.leading, 10)
                }
                Divider()
            }
    }
    
    private enum subjectInfo: String, CaseIterable {
        case all = "전체"
        case operationSystem = "운영체제"
        case network = "네트워크"
        case database = "데이터베이스"
        case structure = "자료구조"
    }
    private enum solveInfo: String, CaseIterable {
        case unsolved = "풀지 않음"
        case solved = "풀이 완료"
    }
    
}
