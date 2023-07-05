//
//  ProfileSettingViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/04.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import PhotosUI

public class ProfileSettingViewModel: ObservableObject {
    
    let nicknameLimit = 10
    let introduceLimit = 250
    let userName: String
    @Published var selectedPhotoData: Data?
    @Published var nickname: LimitedText
    @Published var introduce: LimitedText
    
    public init(userName: String) {
        self.userName = userName
        nickname = LimitedText(limit: nicknameLimit)
        introduce = LimitedText(limit: introduceLimit)
    }
    
    func moveToLearningHomeView() {

    }
    
    func transformPhotoToData(selectedPhoto: PhotosPickerItem?) {
        Task {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                selectedPhotoData = data
            }
        }
    }
}
