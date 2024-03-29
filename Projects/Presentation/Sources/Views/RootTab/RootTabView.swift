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
//    private let tab2: PedigreeListView
    private let tab3: MyPageView
    @State private var selection: Int = 1
    
    public init(tab1: LearningHomeView, tab2: PedigreeListView, tab3: MyPageView) {
        self.tab1 = tab1
//        self.tab2 = tab2
        self.tab3 = tab3
    }
    
    public var body: some View {
        TabView(selection: $selection) {
            tab1
                .tabItem {
                    VStack {
                        Image(systemName: SymbolName.bookClosedFill)
                        Text(StringLiteral.tab1Title)
                    }
                }
                .tag(1)
//            tab2
//                .tabItem {
//                    VStack {
//                        Image(systemName: SymbolName.bookVerticalFill)
//                        Text(StringLiteral.tab2Title)
//                    }
//                }
//                .tag(2)
            tab3
                .tabItem {
                    VStack {
                        Image(systemName: SymbolName.personFill)
                        Text(StringLiteral.tab3Title)
                    }
                }
                .tag(3)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(.Bg_Default)
        }
    }
}
