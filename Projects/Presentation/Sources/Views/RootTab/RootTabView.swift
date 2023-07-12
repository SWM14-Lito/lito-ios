//
//  RootTabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct RootTabView: View {
    
    private let tab1: LearningHomeView
    private let tab2: PrevProblemCategoryView
    private let tab3: MyPageView
    private let tab1ViewModel: LearningHomeViewModel
    @State private var selection: Int = 1
    
    public init(tab1: LearningHomeView, tab2: PrevProblemCategoryView, tab3: MyPageView, tab1ViewModel: LearningHomeViewModel) {
        self.tab1 = tab1
        self.tab2 = tab2
        self.tab3 = tab3
        self.tab1ViewModel = tab1ViewModel
    }
    
    public var body: some View {
        TabView(selection: $selection) {
            tab1
                .tabItem {
                    VStack {
                        Image(systemName: SymbolName.learningTab)
                        Text("학습")
                    }
                }
                .tag(1)
            tab2
                .tabItem {
                    VStack {
                        Image(systemName: SymbolName.prevProblemTab)
                        Text("기출문제")
                    }
                }
                .tag(2)
            tab3
                .tabItem {
                    VStack {
                        Image(systemName: SymbolName.myPageTab)
                        Text("마이페이지")
                    }
                }
                .tag(3)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    tab1ViewModel.moveToLikedProblemView()
                } label: {
                    if selection == 1 {
                        Image(systemName: SymbolName.likedList)
                    } else {
                        EmptyView()
                    }
                }
            }
        }
    }
}
