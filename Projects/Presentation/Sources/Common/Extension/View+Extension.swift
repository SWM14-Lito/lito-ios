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
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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
