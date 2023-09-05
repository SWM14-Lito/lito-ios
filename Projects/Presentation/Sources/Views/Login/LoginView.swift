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
        VStack(spacing: 60) {
            Text("CSTalk")
                .font(.title)
            
            VStack(spacing: 8) {
                Button(action: {
                    viewModel.onAppleLoginButtonClicked()
                }, label: {
                    Image(.btnApplelogin)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                Button(action: {
                    viewModel.onKakaoLoginButttonClicked()
                }, label: {
                    Image(.btnKakaologin)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
            }
            .padding(.horizontal, 30)
        }
        .navigationBarBackButtonHidden(true)
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
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
