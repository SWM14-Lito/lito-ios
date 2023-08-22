//
//  MyPageUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol MyPageUseCase {
    func postLogout() -> AnyPublisher<Void, Error>
    func getUserInfo() -> AnyPublisher<UserInfoVO, Error>
    func patchUserInfo(nickname: String?, introduce: String?) -> AnyPublisher<Void, Error>
    func postProfileImage(image: Data) -> AnyPublisher<Void, Error>
    func postAlarmAcceptance(getAlarm: Bool) -> AnyPublisher<Void, Error>
    func deleteUser() -> AnyPublisher<Void, Error>
}

public final class DefaultMyPageUseCase: MyPageUseCase {
    private let userRepository: UserRepository
    private let authRepository: AuthRepository
    private let fileRepository: FileRepository
    private let imageHelper: ImageHelper
    
    public init(userRepository: UserRepository, authRepository: AuthRepository, fileRepository: FileRepository, imageHelper: ImageHelper) {
        self.userRepository = userRepository
        self.authRepository = authRepository
        self.fileRepository = fileRepository
        self.imageHelper = imageHelper
    }
    
    public func getUserInfo() -> AnyPublisher<UserInfoVO, Error> {
        userRepository.getUserInfo()
    }
    
    public func postLogout() -> AnyPublisher<Void, Error> {
        authRepository.postLogout()
    }
    
    public func patchUserInfo(nickname: String?, introduce: String?) -> AnyPublisher<Void, Error> {
        guard let accessToken = KeyChainManager.read(key: .accessToken) else {
            return Fail(error: ErrorVO.fatalError)
                .eraseToAnyPublisher()
        }
        let profileInfoDTO = ProfileInfoDTO(nickname: nickname, introduce: introduce, accessToken: accessToken)
        return userRepository.patchUserInfo(profileInfoDTO: profileInfoDTO)
    }
    
    public func postProfileImage(image: Data) -> AnyPublisher<Void, Error> {
        guard let accessToken = KeyChainManager.read(key: .accessToken) else {
            return Fail(error: ErrorVO.fatalError)
                .eraseToAnyPublisher()
        }
        let compressedImage = imageHelper.compress(data: image, limit: 500000)
        let profileImageDTO = ProfileImageDTO(image: compressedImage, accessToken: accessToken)
        return fileRepository.postProfileImage(profileImageDTO: ProfileImageDTO(image: compressedImage, accessToken: profileImageDTO.accessToken))
    }
    
    public func postAlarmAcceptance(getAlarm: Bool) -> AnyPublisher<Void, Error> {
        guard let accessToken = KeyChainManager.read(key: .accessToken) else {
            return Fail(error: ErrorVO.fatalError)
                .eraseToAnyPublisher()
        }
        let alarmAcceptanceDTO = AlarmAcceptanceDTO(getAlarm: getAlarm, accessToken: accessToken)
        return userRepository.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
    }
    
    public func deleteUser() -> AnyPublisher<Void, Error> {
        userRepository.deleteUser()
    }
    
}
