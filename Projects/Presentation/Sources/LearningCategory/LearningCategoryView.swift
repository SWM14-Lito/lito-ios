//
//  LearningCategoryView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct LearningCategoryView: View {
    
    @ObservedObject private(set) var viewModel: LearningCategoryViewModel
    
    public init(viewModel: LearningCategoryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("LearningCategoryView")
    }
}
