//
//  FirstView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct ATabFirstView: View {
    
    @EnvironmentObject private var coordinator: ExampleCoordinator
    
    var body: some View {
        VStack {
            Text("This is ATab First View")
            Button {
                coordinator.push(.ATabSecondView(str: "Hi"))
            } label: {
                Text("Move to Second View")
            }
        }
    }
}
