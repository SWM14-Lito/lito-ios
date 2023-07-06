//
//  LearningCategoryView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct LearningCategoryView: View {
    
    @ObservedObject private(set) var viewModel: LearningCategoryViewModel
    
    public init(viewModel: LearningCategoryViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Text("LearningCategoryView")
            Button {
                viewModel.back()
            } label: {
                Text("Back")
            }

        }
    }
}
