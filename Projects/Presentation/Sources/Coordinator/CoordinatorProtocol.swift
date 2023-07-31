//
//  CoordinatorProtocol.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Combine
import Domain

public protocol CoordinatorProtocol {
    func push(_ scene: AppScene)
    func pop()
    func popToRoot()
    func present(sheet: AppScene)
    func dismissSheet()
}
