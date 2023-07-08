//
//  ProfileSettingViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/04.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import PhotosUI
import Domain

public class ProfileSettingViewModel: BaseViewModel, ObservableObject {
    
    let nicknameLimit = 10
    let introduceLimit = 250
    public var userName: String?
    private let cancelBag = CancelBag()
    private let useCase: ProfileSettingUseCase
    @Published var selectedPhotoData: Data?
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var nickname: LimitedText
    @Published var introduce: LimitedText
    @Published var isNicknameExceedLimit: Bool = false
    @Published var isIntroduceExceedLimit: Bool = false
    @Published var error: ErrorVO?
    
    public init(useCase: ProfileSettingUseCase, coordinator: CoordinatorProtocol) {
        self.nickname = LimitedText(limit: nicknameLimit)
        self.introduce = LimitedText(limit: introduceLimit)
        self.useCase = useCase
        super.init(coordinator: coordinator)
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
        
        nickname.reachLimit
            .sink { isExceed in
                self.isNicknameExceedLimit = isExceed ? true : false
            }
            .store(in: cancelBag)
        
        introduce.reachLimit
            .sink { isExceed in
                self.isIntroduceExceedLimit = isExceed ? true : false
            }
            .store(in: cancelBag)
    }
    
    func getIsExceed(fieldCategory: ProfileSettingView.TextFieldCategory) -> Bool {
        switch fieldCategory {
        case .nickname:
            return isNicknameExceedLimit
        case .introduce:
            return isIntroduceExceedLimit
        }
    }
    
    func moveToLearningHomeView() {
        useCase.postProfileInfo(profileSettingVO: ProfileSettingVO(nickname: nickname.text, profileImgUrl: "", introduce: introduce.text, name: userName ?? "Unknown"))
            .sinkToResult { result in
                switch result {
                case .success(_):
                    self.coordinator.push(.learningHomeView)
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.error = errorVO
                    }
                }
            }
            .store(in: cancelBag)
    }
}
