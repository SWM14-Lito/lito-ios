//
//  BTabFirstView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
struct BTabFirstView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("This is BTab First View")
            Button {
                coordinator.push(.BTabSecondView)
            } label: {
                Text("Move to Second View")
            }
            Button {
                coordinator.push(.BTabSecondView)
                coordinator.push(.BTabThirdView)
            } label: {
                Text("Move to Third View (Deep Link)")
            }
        }
    }
}
