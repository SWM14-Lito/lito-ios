//
//  ToastView.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/21.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var message: String
    @Binding var duration: Double
    @Binding var isToastShown: Bool
    @State private var opacityValue: Double = 0.0
    
    init(message: Binding<String>, duration: Binding<Double>, isToastShown: Binding<Bool>) {
        self._message = message
        self._duration = duration
        self._isToastShown = isToastShown
    }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                VStack {
                    Spacer()
                    toastView
                }
                .padding(.bottom, 40)
                .opacity(opacityValue)
            )
            .onChange(of: isToastShown) { _ in
                if isToastShown {
                    showToast()
                }
            }
    }
    
    @ViewBuilder
    private var toastView: some View {
        Text(message)
            .padding(.vertical, 12)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(.Bg_Dark_Gray)
            .cornerRadius(10)
            .padding(.horizontal, 20)

    }
    
    private func showToast() {
        withAnimation {
            opacityValue = 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                opacityValue = 0.0
                isToastShown = false
            }
        }
    }
}
