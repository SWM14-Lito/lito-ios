//
//  ATabSeconddView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct ATabSecondView: View {
    
    @StateObject var coordinator = ATabCoordinator()
    var str: String
    
    init(str: String) {
        self.str = str
    }
    
    
    var body: some View {
        VStack {
            coordinator.navigationLinkSection()
            Text("This is ATab Second View")
            Text(str)
            Button  {
                coordinator.popToRoot()
            } label: {
                Text("Pop to Root")
            }
        }
    }
}

struct ATabSeconddView_Previews: PreviewProvider {
    static var previews: some View {
        ATabSecondView(str: "")
    }
}
