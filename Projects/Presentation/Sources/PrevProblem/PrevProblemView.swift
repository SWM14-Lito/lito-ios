//
//  PrevProblemView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct PrevProblemView: View {
    
    @ObservedObject private(set) var viewModel: PrevProblemViewModel
    
    public init(viewModel: PrevProblemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("PrevProblemView")
    }
}
