//
//  LearningHomeView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct LearningHomeView: View {
    
    @ObservedObject private(set) var viewModel: LearningHomeViewModel
    
    public init(viewModel: LearningHomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("LearningHomeView")
            Button {
                viewModel.moveToLearningCategoryView()
            } label: {
                Text("Move to LearningCategoryView")
            }

        }
    }
}
