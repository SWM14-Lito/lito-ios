//
//  ErrorView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/29.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    //TODO: 정의된 Error에 따라 보여줄 view build
    
    var body: some View {
        VStack {
            Text("An Error Occured")
                .font(.title)
            Text(error.localizedDescription)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40).padding()
            Button(action: retryAction, label: { Text("Retry").bold() })
        }
    }
}

