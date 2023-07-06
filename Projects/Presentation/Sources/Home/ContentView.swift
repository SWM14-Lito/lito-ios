//
//  ContentView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ContentView: View {
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
    
    public init() {}
}
