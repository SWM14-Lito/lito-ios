//
//  View+Extension.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

extension View {
    @ViewBuilder
    func ifLet<V, T>(_ value: V?, transform: (Self, V) -> T) -> some View where T: View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}

extension View {    
    public func toast(message: Binding<String>, duration: Binding<Double>, isToastShown: Binding<Bool>) -> some View {
        return self.modifier(ToastModifier(message: message, duration: duration, isToastShown: isToastShown))
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, transform: (Self) -> Content) -> some View {
        if conditional {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    // 네 모서리 radius 각각 다르게 하고 싶을 때 사용
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    // 커스텀 플레이스홀더
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
