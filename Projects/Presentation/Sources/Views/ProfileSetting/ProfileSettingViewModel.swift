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
    
    private let cancelBag = CancelBag()
    private let useCase: ProfileSettingUseCase
    @Published var selectedPhotoData: Data?
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var username: LimitedText
    @Published var nickname: LimitedText
    @Published var introduce: LimitedText
    @Published var isExceedLimit: [TextFieldCategory: Bool]
    @Published var error: ErrorVO?
    
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
        
        username.reachLimit
            .receive(on: DispatchQueue.main)
            .sink { isExceed in
                self.isExceedLimit[.username] = isExceed ? true : false
            }
            .store(in: cancelBag)
        nickname.reachLimit
            .receive(on: DispatchQueue.main)
            .sink { isExceed in
                self.isExceedLimit[.nickname] = isExceed ? true : false
            }
            .store(in: cancelBag)
        introduce.reachLimit
            .receive(on: DispatchQueue.main)
            .sink { isExceed in
                self.isExceedLimit[.introduce] = isExceed ? true : false
            }
            .store(in: cancelBag)
    }
    
    // TODO: 모든 정보 업로드 성공하면 다음 화면으로 이동하기
    func moveToLearningHomeView() {
        useCase.postProfileInfo(profileInfoDTO: ProfileInfoDTO(name: username.text, nickname: nickname.text, introduce: introduce.text))
            .sinkToResult { result in
                switch result {
                case .success(_):
                    print("info upload success")
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.error = errorVO
                    }
                }
            }
            .store(in: cancelBag)
        
        if let imageData = selectedPhotoData {
            useCase.postProfileImage(profileImageDTO: ProfileImageDTO(image: imageData))
                .sinkToResult { result in
                    switch result {
                    case .success(_):
                        print("image upload success")
                    case .failure(let error):
                        if let errorVO = error as? ErrorVO {
                            self.error = errorVO
                        }
                    }
                }
                .store(in: cancelBag)
        }
        
        // TODO: 알람 여부 사용자에게 받는 기능 필요
        useCase.postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO(getAlarm: true))
            .sinkToResult { result in
                switch result {
                case .success(_):
                    print("alarmAcceptance upload success")
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.error = errorVO
                    }
                }
            }
            .store(in: cancelBag)
    }
}
