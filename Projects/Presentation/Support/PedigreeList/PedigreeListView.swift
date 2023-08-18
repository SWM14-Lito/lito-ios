//
//  PrevProblemView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct PedigreeListView: View {
    
    @ObservedObject private(set) var viewModel: PedigreeListViewModel
    
    public init(viewModel: PedigreeListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("PrevProblemView")
    }
}
