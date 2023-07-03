//
//  ATabSeconddView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
struct ATabSecondView: View {
    
    @EnvironmentObject private var coordinator: ExampleCoordinator
    var str: String
    
    init(str: String) {
        self.str = str
    }
    
    var body: some View {
        VStack {
            Text("This is ATab Second View")
            Text("From previous view: " + str)
            Button {
                coordinator.pop()
            } label: {
                Text("Pop to Root")
            }
        }
    }
}
