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
    
    private var errorView = ErrorView()
    
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.errorView.errorObject = viewModel.errorObject
    }
    
    public var body: some View {
        errorView
        VStack {
            Text("로그인")
                .font(.title)
            
            VStack {
                SignInWithAppleButtonView()
                    .onTapGesture {
                        viewModel.appleLogin()
                    }
                    .frame(width: 280, height: 45)
                    .cornerRadius(10)
                
                Button(action: {
                    viewModel.kakaoLogin()
                }, label: {
                    Image(.btnKakaologin)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .padding(20)

                loginFeedbackView()
                
            }
        }
    }
    
    @ViewBuilder private func loginFeedbackView() -> some View {
        switch viewModel.loginFeedback {
        case .idle:
            EmptyView()
        case .feedback(let text):
            Text(text)
        case .failed(_):
            ErrorView()
        }
    }
}

struct SignInWithAppleButtonView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view controller if needed
    }
}
