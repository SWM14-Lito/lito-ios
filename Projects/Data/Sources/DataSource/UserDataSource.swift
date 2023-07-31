//
//  UserDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol UserDataSource {
    func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error>
    func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error>
}

final public class DefaultUserDataSource: UserDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<UserAPI>()
    
    public func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .setProfileInfo(profileInfoDTO))
    }
    
    public func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .setNotiAcceptance(alarmAcceptanceDTO))
    }
}
