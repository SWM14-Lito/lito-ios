//
//  TabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                ATabFirstView()
                    .tabItem {
                        Text("ATab")
                    }
                
                BTabFirstView()
                    .tabItem {
                        Text("BTab")
                    }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
