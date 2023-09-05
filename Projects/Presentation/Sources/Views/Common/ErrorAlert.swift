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
            CustomAlert(presentAlert: $presentAlert, alertTitle: "에러가 발생했습니다.", alertContent: message, leftButtonTitle: "닫기", rightButtonTitle: "재시도", rightButtonAction: action, alertStyle: .destructive)
        }
    }
}
