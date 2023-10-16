//
//  UserRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

final public class DefaultUserRepository: UserRepository {
    
    private let dataSource: UserDataSource
    
    public init(dataSource: UserDataSource) {
        self.dataSource = dataSource
    }
    
    public func postUserInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        dataSource.postUserInfo(profileInfoDTO: profileInfoDTO)
    }
    
    public func patchUserInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        dataSource.patchUserInfo(profileInfoDTO: profileInfoDTO)
    }

    public func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error> {
        dataSource.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
    }
    
    public func getUserInfo() -> AnyPublisher<UserInfoVO, Error> {
        dataSource.getUserInfo()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func deleteUser() -> AnyPublisher<Void, Error> {
        dataSource.deleteUser()
    }
    
}
