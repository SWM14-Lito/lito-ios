//
//  ProfileSettingDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol ProfileSettingDataSource {
    func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error>
    func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error>
    func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error>
}

public class DefaultProfileSettingDataSource: ProfileSettingDataSource {
    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProfileSettingAPI>()
    
    public func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .setProfileInfo(profileInfoDTO))
    }
    
    public func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .setProfileImage(profileImageDTO))
    }
    
    public func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .setNotiAcceptance(alarmAcceptanceDTO))
    }
}
