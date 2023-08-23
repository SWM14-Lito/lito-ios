//
//  CustomAlert.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/21.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct CustomAlert: View {
    
    @Binding var presentAlert: Bool
    let alertTitle: String
    let alertContent: String
    let leftButtonTitle: String
    let rightButtonTitle: String
    let leftButtonAction: (() -> Void)?
    let rightButtonAction: (() -> Void)?
    let alertStyle: AlertStyle
    
    public init(presentAlert: Binding<Bool>, alertTitle: String, alertContent: String, leftButtonTitle: String, rightButtonTitle: String, leftButtonAction: (() -> Void)? = nil, rightButtonAction: (() -> Void)? = nil, alertStyle: AlertStyle) {
        self._presentAlert = presentAlert
        self.alertTitle = alertTitle
        self.alertContent = alertContent
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
        self.alertStyle = alertStyle
    }

    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(alertTitle)
                    .font(.Head3SemiBold)
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                Text(alertContent)
                    .multilineTextAlignment(.center)
                    .font(.Body2Regular)
                    .foregroundColor(.Text_Serve)
                    .padding(.horizontal, 66)
                    .padding(.bottom, 20)
                HStack(spacing: 12) {
                    Button {
                        if let leftButtonAction {
                            leftButtonAction()
                        }
                        presentAlert.toggle()
                    } label: {
                        Text(leftButtonTitle)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .cornerRadius(6)
                            .font(.Body2Regular)
                            .foregroundColor(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.Button_Negative)
                            }
                    }
                    Button {
                        if let rightButtonAction {
                            rightButtonAction()
                        }
                        presentAlert.toggle()
                    } label: {
                        Text(rightButtonTitle)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .cornerRadius(6)
                            .font(.Body2Regular)
                            .foregroundColor(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(alertStyle == .normal ? .Button_Point : .Button_Red )
                            }
                    }
                }
                .padding(20)
                    
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            }
            .padding(.horizontal, 30)
        }
        
    }
}
