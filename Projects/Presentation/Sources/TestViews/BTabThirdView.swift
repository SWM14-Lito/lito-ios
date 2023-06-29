//
//  BTabThirdView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
struct BTabThirdView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("This is BTab Third View")
            Button  {
                coordinator.popToRoot()
            } label: {
                Text("Pop to Root")
            }
        }
    }
}

//struct BTabThirdView_Previews: PreviewProvider {
//    static var previews: some View {
//        BTabThirdView()
//    }
//}
