//
//  FavoriteProblemListView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct FavoriteProblemListView: View {
    @StateObject private var viewModel: FavoriteProblemListViewModel
    
    public init(viewModel: FavoriteProblemListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Text("FavoriteProblemListView")
    }
}
