//
//  HomeView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain

public struct ExampleView: View {
    
    @ObservedObject private(set) var viewModel: ExampleViewModel
    
    public init(viewModel: ExampleViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            content
                .padding(.bottom, 30)
            Button("Change Quote") {
                self.viewModel.onChangeQuoteButtonClicked()
            }
        }
    }
    
    @ViewBuilder private var content: some View {
        switch viewModel.slip {
        case .notRequested:
            notRequestedView
        case .isLoading:
            loadingView
        case let .loaded(slip):
            loadedView(slip)
        case let .failed(error):
            failedView(error)
        }
    }
}

private extension ExampleView {
    var notRequestedView: some View {
        Text("").onAppear {
            self.viewModel.onChangeQuoteButtonClicked()
        }
    }
    
    var loadingView: some View {
        ProgressView()
    }
    
    func failedView(_ error: ErrorVO) -> some View {
        ErrorView(errorObject: ErrorObject())
    }
    
    func loadedView(_ slip: SlipVO) -> some View {
        Text(slip.advice)
    }
}
