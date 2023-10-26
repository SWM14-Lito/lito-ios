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
            self.uplodadInfoAndMoveToLearningHomeView()
        })
    }
    
    // 글자 입력 관련하여 안채워진게 있는지 확인하기
    private func checkAllTextAreFilled() -> Bool {
        if nickname.text.count < 2 {
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
        let pattern = "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\s]*$"
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

        Task {
            do {
                if let data = imageData {
                    try await sendProfileImage(data: data)
                    try await sendProfileInfo()
                    try await sendAlarmAcceptance()
                } else {
                    try await sendProfileInfo()
                    try await sendAlarmAcceptance()
                }
                KeyChainManager.createUserInfo(userAuthVO: self.userAuthVO)
                await MainActor.run {
                    self.coordinator.pop()
                    self.coordinator.push(.rootTabScene)
                }
            } catch {
                buttonIsLocked = false
            }
        }
    }
    
    private func sendProfileImage(data: Data) async throws {
        let dto = ProfileImageDTO(image: data, accessToken: userAuthVO.accessToken)
        let publisher = useCase.postProfileImage(profileImageDTO: dto)
        
        try await withCheckedThrowingContinuation { continuation in
            publisher
                .receive(on: DispatchQueue.main)
                .sinkToResultWithHandler({ result in
                    switch result {
                    case .success( _):
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }, errorHandler: errorHandler)
                .store(in: cancelBag)
        }
    }
    
    private func sendProfileInfo() async throws {
        let dto = ProfileInfoDTO(nickname: nickname.text, introduce: introduce.text, accessToken: userAuthVO.accessToken)
        let publisher = useCase.postProfileInfo(profileInfoDTO: dto)
        
        try await withCheckedThrowingContinuation { continuation in
            publisher
                .receive(on: DispatchQueue.main)
                .sinkToResultWithHandler({ result in
                    switch result {
                    case .success( _):
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }, errorHandler: errorHandler)
                .store(in: cancelBag)
        }
    }
    
    private func sendAlarmAcceptance() async throws {
        let dto = AlarmAcceptanceDTO(getAlarm: acceptAlarm, accessToken: userAuthVO.accessToken)
        let publisher = useCase.postAlarmAcceptance(alarmAcceptanceDTO: dto)
        
        try await withCheckedThrowingContinuation { continuation in
            publisher
                .receive(on: DispatchQueue.main)
                .sinkToResultWithHandler({ result in
                    switch result {
                    case .success( _):
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }, errorHandler: errorHandler)
                .store(in: cancelBag)
        }
    }
}
