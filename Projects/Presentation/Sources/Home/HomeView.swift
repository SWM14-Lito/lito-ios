//
//  HomeView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain

public struct HomeView: View {
    
    @ObservedObject private(set) var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack{
            content
                .padding(.bottom, 30)
            Button("Change Quote") {
                self.viewModel.loadSlip()
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

private extension HomeView {
    var notRequestedView: some View {
        Text("").onAppear {
            self.viewModel.loadSlip()
        }
    }
    
    var loadingView: some View {
       ProgressView()
    }
    
    func failedView(_ error: Error) -> some View {
        Text("Unable to load string")
    }
    
    func loadedView(_ slip: SlipVO) -> some View {
        Text(slip.advice)
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: .init(container: .preview))
//    }
//}
