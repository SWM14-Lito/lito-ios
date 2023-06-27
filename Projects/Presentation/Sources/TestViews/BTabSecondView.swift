//
//  BTabSecondView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct BTabSecondView: View {
    
    @StateObject var coordinator = BTabCoordinator()
    
    var body: some View {
        VStack {
            coordinator.navigationLinkSection()
            Text("This is BTab Second View")
            Button  {
                coordinator.push(destination: .thirdView)
            } label: {
                Text("Move to Third View")
            }
        }
    }
}

struct BTabSecondView_Previews: PreviewProvider {
    static var previews: some View {
        BTabSecondView()
    }
}
