//
//  CoordinatorProtocol.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public protocol CoordinatorProtocol {
    var path: Published<NavigationPath>.Publisher { get set }
    
    func buildLearningTabRootView() -> LearningHomeView
    func buildPrevProblemTabRootView() -> PrevProblemCategoryView
    func buildMyPageTabRootView() -> MyPageView
    func push(_ page: Page)
    func pop()
    func popToRoot()
}
