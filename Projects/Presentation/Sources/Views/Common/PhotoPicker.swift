//
//  PhotoPicker.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import PhotosUI
import SwiftUI

struct PhotoPicker: View {
    @State private var item: PhotosPickerItem?
    @Binding private var imageData: Data?
    
    init(imageData: Binding<Data?>) {
        self._imageData = imageData
    }
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $item, matching: .images) {
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                        .padding(.top, 30)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                        .padding(.top, 30)
                }
            }
        }
        .onChange(of: item) { _ in
            Task {
                if let data = try? await item?.loadTransferable(type: Data.self) {
                    imageData = data
                }

                print("Failed")
            }
        }
    }
}
