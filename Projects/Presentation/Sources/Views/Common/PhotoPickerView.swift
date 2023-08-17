//
//  PhotoPicker.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import PhotosUI
import SwiftUI

// 클릭 시 앨범 열려서 선택 가능한 이미지
struct PhotoPickerView: View {
    @State private var item: PhotosPickerItem?
    @Binding private var imageData: Data?
    
    init(imageData: Binding<Data?>) {
        self._imageData = imageData
    }
    
    var body: some View {
        PhotosPicker(selection: $item, matching: .images) {
            pickerThumbnailImage
                .resizable()
                .frame(width: 74, height: 74)
                .clipShape(Circle())
                .foregroundColor(.gray)
        }
        .overlay {
            Image(systemName: SymbolName.cameraCircleFill)
                .resizable()
                .foregroundStyle(.white, .Icon_Default)
                .frame(width: 24, height: 24)
                .padding(.top, 50)
                .padding(.leading, 50)
                .overlay {
                    Circle()
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 24, height: 24)
                        .padding(.top, 50)
                        .padding(.leading, 50)
                }
        }
        .onChange(of: item) { _ in
            Task {
                if let data = try? await item?.loadTransferable(type: Data.self) {
                    imageData = data
                }
            }
        }
    }
    
    private var pickerThumbnailImage: Image {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: SymbolName.personCircleFill)
        }
    }
}
