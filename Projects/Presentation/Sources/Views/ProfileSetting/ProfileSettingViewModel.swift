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
    
    private let cancelBag = CancelBag()
    private let useCase: ProfileSettingUseCase
    private var acceptAlarm: Bool = false
    private(set) var buttonIsLocked: Bool = false
    @Published var imageData: Data?
    @Published var username: LimitedText
    @Published var nickname: LimitedText
    @Published var introduce: LimitedText
    @Published private(set) var isExceedLimit: [TextFieldCategory: Bool]
    @Published private(set) var errorObject = ErrorObject()

    enum TextFieldCategory: Hashable {
        case username, nickname, introduce
        var limit: Int {
            switch self {
            case .username:
                return 10
            case .nickname:
                return 10
            case .introduce:
                return 250
            }
        }
        var title: String {
            switch self {
            case .username:
                return "이름"
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
    
    public init(useCase: ProfileSettingUseCase, coordinator: CoordinatorProtocol) {
        self.username = LimitedText(limit: TextFieldCategory.username.limit)
        self.nickname = LimitedText(limit: TextFieldCategory.nickname.limit)
        self.introduce = LimitedText(limit: TextFieldCategory.introduce.limit)
        self.isExceedLimit = [.username: false, .nickname: false, .introduce: false]
        self.useCase = useCase
        super.init(coordinator: coordinator)
        initPublisher()
    }
    
    // 각 글자가 제한수에 도달하는지 확인
    func initPublisher() {
        username.reachedLimit
            .receive(on: DispatchQueue.main)
            .sink { isExceed in
                self.isExceedLimit[.username] = isExceed ? true : false
            }
            .store(in: cancelBag)
        nickname.reachedLimit
            .receive(on: DispatchQueue.main)
            .sink { isExceed in
                self.isExceedLimit[.nickname] = isExceed ? true : false
            }
            .store(in: cancelBag)
        introduce.reachedLimit
            .receive(on: DispatchQueue.main)
            .sink { isExceed in
                self.isExceedLimit[.introduce] = isExceed ? true : false
            }
            .store(in: cancelBag)
    }
    
    // API 연결해서 정보 업로드하고 탭뷰 (학습메인) 으로 이동하기
    func moveToLearningHomeView() {
        buttonIsLocked = true
        let profileInfoDTO = ProfileInfoDTO(name: username.text, nickname: nickname.text, introduce: introduce.text)
        let alarmAcceptanceDTO = AlarmAcceptanceDTO(getAlarm: acceptAlarm)
        
        let postProfileInfoPublisher = useCase.postProfileInfo(profileInfoDTO: profileInfoDTO)
        let postAlarmAcceptancePublusher = useCase.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
        
        // 프로필 이미지도 설정했을 경우
        if let data = imageData {
            let profileImageDTO = ProfileImageDTO(image: UIImage(data: data)?.jpegData(compressionQuality: 0.5) ?? Data())
            let postProfileImagePublisher = useCase.postProfileImage(profileImageDTO: profileImageDTO)
            
            postProfileInfoPublisher
                .combineLatest(postProfileImagePublisher, postAlarmAcceptancePublusher) { _, _, _ in }
                .sinkToResult { result in
                    switch result {
                    case .success(_):
                        self.coordinator.push(.rootTabView)
                    case .failure(let error):
                        if let errorVO = error as? ErrorVO {
                            self.errorObject.error  = errorVO
                            self.buttonIsLocked = false
                        }
                    }
                }
                .store(in: cancelBag)
        }
        // 이름, 닉네임, 소개글만 작성했을 경우
        else {
            postProfileInfoPublisher
                .combineLatest(postAlarmAcceptancePublusher) { _, _ in }
                .sinkToResult { result in
                    switch result {
                    case .success(_):
                        self.coordinator.push(.rootTabView)
                    case .failure(let error):
                        if let errorVO = error as? ErrorVO {
                            self.errorObject.error  = errorVO
                            self.buttonIsLocked = false
                        }
                    }
                }
                .store(in: cancelBag)
        }
    }
    
    // 알람 받을건지 여부 확인하기
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, _ in
            if didAllow {
                self.acceptAlarm = true
            } else {
                self.acceptAlarm = false
            }
        })
    }
}
