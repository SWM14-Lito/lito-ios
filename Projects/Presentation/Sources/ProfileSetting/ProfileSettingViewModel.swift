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
    private let cancelBag = CancelBag()
    @Published var selectedPhotoData: Data?
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var nickname: LimitedText
    @Published var introduce: LimitedText
    
    public init(userName: String) {
        self.userName = userName
        nickname = LimitedText(limit: nicknameLimit)
        introduce = LimitedText(limit: introduceLimit)
        initPublisher()
    }
    
    func initPublisher() {
        $selectedPhoto
            .sink { value in
                value?.loadTransferable(type: Data.self) { result in
                    DispatchQueue.main.async {
                        self.selectedPhotoData = try? result.get()
                    }
                }
            }
            .store(in: cancelBag)
    }
    
    func moveToLearningHomeView() {
        
    }
}
