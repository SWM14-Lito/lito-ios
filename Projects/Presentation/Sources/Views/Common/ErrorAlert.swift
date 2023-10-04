//
//  ErrorAlert.swift
//  Presentation
//
//  Created by 김동락 on 2023/09/05.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct ErrorAlert: ViewModifier {
    @Binding var presentAlert: Bool
    let message: String
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        ZStack {
            content
            CustomAlert(presentAlert: $presentAlert, alertTitle: StringLiteral.errorAlertTitle, alertContent: message, leftButtonTitle: StringLiteral.errorAlertLeftButtonTitle, rightButtonTitle: StringLiteral.errorAlertRightButtonTitle, rightButtonAction: action, alertStyle: .destructive)
        }
    }
}
