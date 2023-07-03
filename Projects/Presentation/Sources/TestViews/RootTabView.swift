//
//  TabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
struct RootTabView: View {
    
    // swinject로 의존성 주입 받기?
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            TabView {
                coordinator.build(page: .ATabFirstView)
                    .tabItem { Text("ATab") }
                coordinator.build(page: .BTabFirstView)
                    .tabItem { Text("BTab") }
            }
            .navigationDestination(for: Page.self) { page in
                coordinator.build(page: page)
            }
        }
        .environmentObject(coordinator)
    }
}
