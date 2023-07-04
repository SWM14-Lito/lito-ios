//
//  ProfileSettingView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/04.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import PhotosUI

public struct ProfileSettingView: View {
    @ObservedObject private(set) var viewModel: ProfileSettingViewModel
    @StateObject private var keyboardHandler = KeyboardHandler()
    @FocusState private var focus: TextFieldCategory?
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @ObservedObject private var nickname = LimitedText(limit: 10)
    @ObservedObject private var introduce = LimitedText(limit: 250)
    private let name: String
    
    public init(viewModel: ProfileSettingViewModel, name: String) {
        self.viewModel = viewModel
        self.name = name
    }
    
    public var body: some View {
        VStack {
            setProfileImageView(photoItem: $selectedPhoto, photoData: $selectedPhotoData)
            nameView(text: name)
            setTextFieldView(fieldCategory: .nickname, limitedText: _nickname, focus: _focus)
            setTextFieldView(fieldCategory: .introduce, limitedText: _introduce, focus: _focus)
            Spacer()
            finishButtonView()
        }
//        .padding(.bottom, keyboardHandler.keyboardHeight)
        .padding([.leading, .trailing], 15)
        .onAppear {
            focus = .nickname
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    switch focus {
                    case .nickname:
                        focus = .introduce
                    case .introduce:
                        focus = nil
                    case .none:
                        break
                    }
                } label: {
                    Text("Done")
                }
            }
        }
    }
    
    // 프로필 이미지 설정 뷰
    @ViewBuilder
    private func setProfileImageView(photoItem: Binding<PhotosPickerItem?>, photoData: Binding<Data?>) -> some View {
        PhotosPicker(selection: $selectedPhoto) {
            if let selectedPhotoData,
               let image = UIImage(data: selectedPhotoData) {
                Image(uiImage: image)
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
        .onChange(of: selectedPhoto) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedPhotoData = data
                }
            }
        }
    }
    
    // 이름 보여주는 뷰 (소셜 로그인 화면에서 넘겨받기)
    @ViewBuilder
    private func nameView(text: String) -> some View {
        VStack {
            Text("이름")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 10))
                .padding(.bottom, 2)
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
                .foregroundColor(.gray)
            Divider()
        }
    }
    
    // 텍스트 입력 뷰 (닉네임, 소개말)
    @ViewBuilder
    private func setTextFieldView(fieldCategory: TextFieldCategory, limitedText: ObservedObject<LimitedText>, focus: FocusState<TextFieldCategory?>) -> some View {
        
        let curLength = String(limitedText.wrappedValue.text.count)
        let maxLength = String(limitedText.wrappedValue.limit)
        
        VStack {
            Text(fieldCategory.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 10))
            ZStack(alignment: .bottomTrailing) {
                TextField(fieldCategory.placeHolder, text: limitedText.projectedValue.text, axis: .vertical)
                    .font(.system(size: 15))
                    .padding(.trailing, 70)
                    .focused($focus, equals: fieldCategory)
                HStack {
                    Text(curLength + "/" + maxLength)
                        .font(.system(size: 10))
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            limitedText.projectedValue.text.wrappedValue = ""
                        }
                }
            }
            Divider()
        }
    }
    
    // 설정 완료 버튼 뷰
    @ViewBuilder
    private func finishButtonView() -> some View {
        Button {
            viewModel.moveToLearningHomeView()
        } label: {
            Text("설정하기")
        }
        .buttonStyle(.bordered)
        .tint(.orange)
        .padding(.bottom, 20)

    }
}

extension ProfileSettingView {
    private enum TextFieldCategory: Hashable {
        case nickname, introduce
        var title: String {
            switch self {
            case .nickname:
                return "닉네임"
            case .introduce:
                return "소개말"
            }
        }
        var placeHolder: String {
            return title + "을 입력해주세요."
        }
    }
}
