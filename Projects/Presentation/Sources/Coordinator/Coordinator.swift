//
//  LearningTabCoordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

enum Page: Hashable {
    case ATabFirstView
    case ATabSecondView(str: String)
    case BTabFirstView
    case BTabSecondView
    case BTabThirdView
}

@available(iOS 16.0, *)
class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .ATabFirstView:
            ATabFirstView()
        case .ATabSecondView(let str):
            ATabSecondView(str: str)
        case .BTabFirstView:
            BTabFirstView()
        case .BTabSecondView:
            BTabSecondView()
        case .BTabThirdView:
            BTabThirdView()
        }
    }
}
