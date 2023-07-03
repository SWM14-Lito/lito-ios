//
//  BTabSecondView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct BTabSecondView: View {
    
    @EnvironmentObject private var coordinator: ExampleCoordinator
    
    var body: some View {
        VStack {
            Text("This is BTab Second View")
            Button {
                coordinator.push(.BTabThirdView)
            } label: {
                Text("Move to Third View")
            }
        }
    }
}
