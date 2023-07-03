//
//  TabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct ExampleRootTabView: View {
    
    // swinject로 의존성 주입 받기?
    @StateObject private var coordinator = ExampleCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            TabView {
                coordinator.build(page: .ATabFirstView)
                    .tabItem { Text("ATab") }
                coordinator.build(page: .BTabFirstView)
                    .tabItem { Text("BTab") }
            }
            .navigationDestination(for: ExamplePage.self) { page in
                coordinator.build(page: page)
            }
        }
        .environmentObject(coordinator)
    }
}
