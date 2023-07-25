//
//  SolvingProblemView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct SolvingProblemListView: View {
    @StateObject private var viewModel: SolvingProblemListViewModel
    
    public init(viewModel: SolvingProblemListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Text("SolvingProblemListView")
    }
}
