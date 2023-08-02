//
//  UrlImageView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/18.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Kingfisher

// Url에서 다운 받아서 보여주는 이미지
struct UrlImageView: View {
    
    let urlString: String?
    
    var body: some View {
        if let urlString = urlString,
           let url = URL(string: urlString) {
            KFImage(url)
                .placeholder {
                    defaultImage
                }
                .resizable()
        } else {
            defaultImage
        }
    }
    
    private var defaultImage: Image {
        Image(systemName: SymbolName.defaultProfile)
            .resizable()
    }
}
