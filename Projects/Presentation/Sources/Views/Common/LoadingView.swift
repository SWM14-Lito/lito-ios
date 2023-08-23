//
//  LoadingView.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/21.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            LottieView(filename: "loadingCircle")
                .frame(width: 54, height: 54)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
