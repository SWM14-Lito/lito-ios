//
//  BTabFirstView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct BTabFirstView: View {
    
    @StateObject var coordinator = BTabCoordinator(isRoot: true)
    
    var body: some View {
        VStack {
            coordinator.navigationLinkSection()
            Text("This is BTab First View")
            Button  {
                coordinator.push(destination: .secondView)
            } label: {
                Text("Move to Second View")
            }
        }
    }
}

struct BTabFirstView_Previews: PreviewProvider {
    static var previews: some View {
        BTabFirstView()
    }
}
