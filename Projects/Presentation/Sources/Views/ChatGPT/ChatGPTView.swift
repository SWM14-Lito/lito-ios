//
//  ChatGPTView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/28.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ChatGPTView: View {
    
    @StateObject private var viewModel: ChatGPTViewModel
    
    public init(viewModel: ChatGPTViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Text("ChatGPTView")
    }
}
