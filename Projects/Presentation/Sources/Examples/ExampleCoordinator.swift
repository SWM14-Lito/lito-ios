//
//  LearningTabCoordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

// 탭별로 화면을 나눠야하할까
// 근데 B탭 화면에서 A탭 화면으로 이동하는게 있다면?
enum ExamplePage: Hashable {
    case ATabFirstView
    case ATabSecondView(str: String)
    case BTabFirstView
    case BTabSecondView
    case BTabThirdView
}

@available(iOS 16.0, *)
class ExampleCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ page: ExamplePage) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    // 여러 뷰 없애는거면 애니메이션 효과가 적용되지 않음
    // 커스텀 애니메이션 필요?
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: ExamplePage) -> some View {
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
