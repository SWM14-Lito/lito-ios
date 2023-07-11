//
//  LearningHomeView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct LearningHomeView: View {
    
    @StateObject private var viewModel: LearningHomeViewModel
    
    public init(viewModel: LearningHomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
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
