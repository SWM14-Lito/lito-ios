//
//  FirstView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct ATabFirstView: View {
    
    @StateObject var coordinator = ATabCoordinator(isRoot: true)
    
    var body: some View {
        VStack {
            coordinator.navigationLinkSection()
            Text("This is ATab First View")
            Button  {
                coordinator.push(destination: .secondView("Hi"))
            } label: {
                Text("Move to Second View")
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        ATabFirstView()
    }
}
