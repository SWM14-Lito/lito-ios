//
//  MyPageViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain
import Kingfisher

public class MyPageViewModel: BaseViewModel {
    
    private let useCase: MyPageUseCase
    @Published var userInfo: UserInfoVO?
    @Published var imageData: Data?
    @Published var alarmStatus: Bool = true
    @Published var modifyNickNameInput = LimitedText(limit: ProfileTextFieldCategory.nickname.limit)
    @Published var modifyIntroduceInput = LimitedText(limit: ProfileTextFieldCategory.introduce.limit)
    
    public init(useCase: MyPageUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
    }

    public func getUserInfo() {
        useCase.getUserInfo()
            .sinkToResult { result in
                switch result {
                case .success(let userInfoVO):
                    self.userInfo = userInfoVO
                    self.alarmStatus = userInfoVO.alarmStatus
                    self.modifyNickNameInput.text = userInfoVO.nickname
                    self.modifyIntroduceInput.text = userInfoVO.introduce
                    if let imageUrl = URL(string: userInfoVO.profileImgUrl) {
                        KingfisherManager.shared.retrieveImage(with: imageUrl) { result in
                            switch result {
                            case .success(let value):
                                if let imageData = value.image.pngData() {
                                    self.imageData = imageData
                                }
                            case .failure:
                                break
                            }
                        }
                    }
                case .failure:
                    break
                }
            }
            .store(in: cancelBag)
    }
    
    public func postLogout() {
        useCase.postLogout()
            .sinkToResult { result in
                switch result {
                case .success:
                    KeyChainManager.deleteUserInfo()
                    self.coordinator.popToRoot()
                case .failure:
                    break
                }
            }
            .store(in: cancelBag)
    }
    
    public func postProfileInfo() {
        guard let userInfo = userInfo else { return }
        var nickname: String?
        var introduce: String?
        if userInfo.nickname != modifyNickNameInput.text {
            nickname = modifyNickNameInput.text
        }
        if userInfo.introduce != modifyIntroduceInput.text {
            introduce = modifyIntroduceInput.text
        }
        useCase.postProfileInfo(nickname: nickname, introduce: introduce)
            .sinkToResultWithErrorHandler({ _ in
                self.coordinator.pop()
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    public func postAlarmAcceptance() {
        useCase.postAlarmAcceptance(getAlarm: alarmStatus)
            .sinkToResultWithErrorHandler({ _ in
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    public func moveToModifyProfileView() {
        coordinator.push(.modifyProfileScene)
    }
    
}

extension MyPageViewModel: PhotoPickerHandling {
    
    public func postProfileImage() {
        print("upload image")
        guard let imageData = imageData else { return }
        useCase.postProfileImage(image: imageData)
            .sinkToResultWithErrorHandler({ _ in
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
}
