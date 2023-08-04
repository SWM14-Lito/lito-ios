//
//  ProfileSettingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProfileSettingUseCase {
    func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error>
    func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error>
    func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error>
}

public final class DefaultProfileSettingUseCase: ProfileSettingUseCase {
    private let userRepository: UserRepository
    private let fileRepository: FileRepository
    private let imageHelper: ImageHelper
    
    public init(userRepository: UserRepository, fileRepository: FileRepository, imageHelper: ImageHelper) {
        self.userRepository = userRepository
        self.fileRepository = fileRepository
        self.imageHelper = imageHelper
    }
    
    public func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        userRepository.postProfileInfo(profileInfoDTO: profileInfoDTO)
    }
    
    public func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error> {
        let compressedImage = imageHelper.compress(data: profileImageDTO.image, limit: 500000)
        return fileRepository.postProfileImage(profileImageDTO: ProfileImageDTO(image: compressedImage, accessToken: profileImageDTO.accessToken))
    }
    
    public func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error> {
        userRepository.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
    }
}
