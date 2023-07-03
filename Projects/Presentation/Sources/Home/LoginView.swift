//
//  LoginView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import AuthenticationServices
import Domain

public struct LoginView: View {
    
    @ObservedObject private(set) var viewModel: LoginViewModel
    
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack {
            Text("로그인")
                .font(.title)

            VStack {
                Button(action: {
                    viewModel.kakaoLogin()
                }, label: {
                    Image(.btnKakaologin) // Replace with the name of your image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .padding(20)

            }
            SignInWithAppleButton(onRequest: viewModel.appleLoginOnRequest, onCompletion: viewModel.appleLoginOnCompletion)
            .frame(width: 280, height: 45)
            .cornerRadius(10)
        }
        
    }
    
//    @ViewBuilder private var content: some View {
//        switch viewModel.slip {
//        case .notRequested:
//            notRequestedView
//        case .isLoading:
//            loadingView
//        case let .loaded(slip):
//            loadedView(slip)
//        case let .failed(error):
//            failedView(error)
//        }
//    }
}

// private extension LoginView {
//    var notRequestedView: some View {
//        Text("").onAppear {
//            //            self.viewModel.loadSlip()
//        }
//    }
//
//    var loadingView: some View {
//        ProgressView()
//    }
//
//    func failedView(_ error: NetworkErrorVO) -> some View {
//        ErrorView(error: error, retryAction: self.viewModel.loadSlip)
//    }
//
//    func loadedView(_ slip: SlipVO) -> some View {
//        Text(slip.advice)
//    }
// }
