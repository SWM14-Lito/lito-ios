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
import Combine

public class ProfileSettingViewModel: BaseViewModel {
    
    private let useCase: ProfileSettingUseCase
    private var acceptAlarm: Bool = false
    private(set) var buttonIsLocked: Bool = false
    private var userAuthVO: UserAuthVO
    @Published var imageData: Data?
    @Published var username = LimitedText(limit: ProfileTextFieldCategory.username.limit)
    @Published var nickname = LimitedText(limit: ProfileTextFieldCategory.nickname.limit)
    @Published var introduce = LimitedText(limit: ProfileTextFieldCategory.introduce.limit)
    @Published var textErrorMessage: String?
    
    public init(userAuthVO: UserAuthVO, useCase: ProfileSettingUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.userAuthVO = userAuthVO
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
    }

    // 알람 받을건지 여부 확인하기
    public func onFinishButtonClicked() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, _ in
            if didAllow {
                self.acceptAlarm = true
            } else {
                self.acceptAlarm = false
            }
            DispatchQueue.main.async {
                self.moveToLearningHomeView()
            }
        })
    }
    
    // 글자 입력 관련하여 안채워진게 있는지 확인하기
    private func checkAllTextAreFilled() -> Bool {
        if username.text.isEmpty {
            textErrorMessage = ProfileTextFieldCategory.username.errorMessage
            return false
        } else if nickname.text.isEmpty {
            textErrorMessage = ProfileTextFieldCategory.nickname.errorMessage
            return false
        } else {
            textErrorMessage = nil
            return true
        }
    }
    
    // API 연결해서 정보 업로드하고 탭뷰 (학습메인) 으로 이동하기
    private func moveToLearningHomeView() {
        lastNetworkAction = moveToLearningHomeView
        
        guard checkAllTextAreFilled() else { return }
        
        buttonIsLocked = true
        let profileInfoDTO = ProfileInfoDTO(name: username.text, nickname: nickname.text, introduce: introduce.text, accessToken: userAuthVO.accessToken)
        let alarmAcceptanceDTO = AlarmAcceptanceDTO(getAlarm: acceptAlarm, accessToken: userAuthVO.accessToken)
        
        let postProfileInfoPublisher = useCase.postProfileInfo(profileInfoDTO: profileInfoDTO)
        let postAlarmAcceptancePublusher = useCase.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
        
        // 프로필 이미지도 설정했을 경우
        if let data = imageData {
            let profileImageDTO = ProfileImageDTO(image: data, accessToken: userAuthVO.accessToken)
            let postProfileImagePublisher = useCase.postProfileImage(profileImageDTO: profileImageDTO)
            
            postProfileInfoPublisher
                .combineLatest(postProfileImagePublisher, postAlarmAcceptancePublusher) { _, _, _ in }
                .sinkToResultWithHandler({ result in
                    switch result {
                    case .success( _):
                        KeyChainManager.createUserInfo(userAuthVO: self.userAuthVO)
                        self.coordinator.pop()
                        self.coordinator.push(.rootTabScene)
                    case .failure( _):
                        break
                    }
                    self.buttonIsLocked = false
                }, errorHandler: errorHandler)
                .store(in: cancelBag)
        }
        // 이름, 닉네임, 소개글만 작성했을 경우
        else {
            postProfileInfoPublisher
                .combineLatest(postAlarmAcceptancePublusher) { _, _ in }
                .sinkToResultWithErrorHandler({ _ in
                    KeyChainManager.createUserInfo(userAuthVO: self.userAuthVO)
                    self.coordinator.pop()
                    self.coordinator.push(.rootTabScene)
                    self.buttonIsLocked = false
                }, errorHandler: errorHandler)
                .store(in: cancelBag)
        }
    }
  
    public func viewOnAppear() {
        self.username.text = userAuthVO.userName
    }
}
