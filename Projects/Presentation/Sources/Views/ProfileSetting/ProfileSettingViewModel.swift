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

public class ProfileSettingViewModel: BaseViewModel, ObservableObject {
    
    private let cancelBag = CancelBag()
    private let useCase: ProfileSettingUseCase
    @Published var selectedPhotoData: Data?
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var username: LimitedText
    @Published var nickname: LimitedText
    @Published var introduce: LimitedText
    @Published var isExceedLimit: [TextFieldCategory: Bool]
    private var succeedUploadingProfileInfo = false
    private var succeedUploadingProfileImage = false
    private var succeedUploadingProfileAlarmStatus = false
    @Published var uploadError: ErrorVO?
    
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
    
    func moveToLearningHomeView() {
        if let img = selectedPhotoData {
            postProfile(img: img)
                .sink { _ in
                    if self.succeedUploadingProfileInfo && self.succeedUploadingProfileImage && self.succeedUploadingProfileAlarmStatus {
                        self.coordinator.push(.rootTabView)
                    }
                }
                .store(in: cancelBag)
        } else {
            postProfile()
                .sink { _ in
                    if self.succeedUploadingProfileInfo && self.succeedUploadingProfileAlarmStatus {
                        self.coordinator.push(.rootTabView)
                    }
                }
                .store(in: cancelBag)
        }
    }
    
    func postProfile(img: Data? = nil) -> Future<Bool, Never> {
        return Future<Bool, Never> { promise in
            self.useCase.postProfileInfo(profileInfoDTO: ProfileInfoDTO(name: self.username.text, nickname: self.nickname.text, introduce: self.introduce.text))
                .sinkToResult { result in
                    switch result {
                    case .success(_):
                        print("info upload success")
                        self.succeedUploadingProfileInfo = true
                        promise(.success(true))
                    case .failure(let error):
                        if let errorVO = error as? ErrorVO {
                            self.uploadError = errorVO
                        }
                    }
                }
                .store(in: self.cancelBag)
            
            if let img = img {
                self.useCase.postProfileImage(profileImageDTO: ProfileImageDTO(image: img))
                    .sinkToResult { result in
                        switch result {
                        case .success(_):
                            print("image upload success")
                            self.succeedUploadingProfileImage = true
                            promise(.success(true))
                        case .failure(let error):
                            if let errorVO = error as? ErrorVO {
                                self.uploadError = errorVO
                            }
                        }
                    }
                    .store(in: self.cancelBag)
            }
            
            // TODO: 알람 여부 사용자에게 받는 기능 필요
            self.useCase.postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO(getAlarm: true))
                .sinkToResult { result in
                    switch result {
                    case .success(_):
                        print("alarmAcceptance upload success")
                        self.succeedUploadingProfileAlarmStatus = true
                        promise(.success(true))
                    case .failure(let error):
                        if let errorVO = error as? ErrorVO {
                            self.uploadError = errorVO
                        }
                    }
                }
                .store(in: self.cancelBag)
        }
    }
}
