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
                self.uplodadInfoAndMoveToLearningHomeView()
            }
        })
    }
    
    // 글자 입력 관련하여 안채워진게 있는지 확인하기
    private func checkAllTextAreFilled() -> Bool {
        if username.text.count < 2 {
            textErrorMessage = ProfileTextFieldCategory.username.errorMessageForLength
            return false
        } else if !IsAlpOrNum(username.text) {
            textErrorMessage = ProfileTextFieldCategory.username.errrorMessageForSpecialCharacter
            return false
        } else if nickname.text.count < 2 {
            textErrorMessage = ProfileTextFieldCategory.nickname.errorMessageForLength
            return false
        } else if !IsAlpOrNum(nickname.text) {
            textErrorMessage = ProfileTextFieldCategory.nickname.errrorMessageForSpecialCharacter
            return false
        } else {
            textErrorMessage = nil
            return true
        }
    }
    
    private func IsAlpOrNum(_ str: String) -> Bool {
        let pattern = "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]*$"
        if str.range(of: pattern, options: .regularExpression) != nil {
            return true
        } else {
            return false
        }
    }
    
    // API 연결해서 정보 업로드하고 탭뷰 (학습메인) 으로 이동하기
    private func uplodadInfoAndMoveToLearningHomeView() {
        lastNetworkAction = uplodadInfoAndMoveToLearningHomeView
        
        guard checkAllTextAreFilled() else { return }
        
        buttonIsLocked = true
        preparePublisher()
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
    
    private func preparePublisher() -> AnyPublisher<Any, Error> {
        let profileInfoDTO = ProfileInfoDTO(name: username.text, nickname: nickname.text, introduce: introduce.text, accessToken: userAuthVO.accessToken)
        let alarmAcceptanceDTO = AlarmAcceptanceDTO(getAlarm: acceptAlarm, accessToken: userAuthVO.accessToken)
        
        let postProfileInfoPublisher = useCase.postProfileInfo(profileInfoDTO: profileInfoDTO)
        let postAlarmAcceptancePublusher = useCase.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
        
        if let data = imageData {
            let profileImageDTO = ProfileImageDTO(image: data, accessToken: userAuthVO.accessToken)
            let postProfileImagePublisher = useCase.postProfileImage(profileImageDTO: profileImageDTO)
            
            return postProfileInfoPublisher
                .combineLatest(postProfileImagePublisher, postAlarmAcceptancePublusher) { _, _, _ in }
                .eraseToAnyPublisher()
        } else {
            return postProfileInfoPublisher
                .combineLatest(postAlarmAcceptancePublusher) { _, _ in }
                .eraseToAnyPublisher()
        }
    }
  
    public func viewOnAppear() {
        self.username.text = userAuthVO.userName
    }
}
