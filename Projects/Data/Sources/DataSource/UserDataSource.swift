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
    func postUserInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error>
    func patchUserInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error>
    func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error>
    func getUserInfo() -> AnyPublisher<UserInfoDTO, Error>
    func deleteUser() -> AnyPublisher<Void, Error>
}

final public class DefaultUserDataSource: UserDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<UserAPI>()
    
    public func postUserInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .postUserInfo(profileInfoDTO))
    }
    
    public func patchUserInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .patchUserInfo(profileInfoDTO))
    }
    
    public func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .setNotiAcceptance(alarmAcceptanceDTO))
    }
    
    public func getUserInfo() -> AnyPublisher<UserInfoDTO, Error> {
        guard let userId = KeyChainManager.read(key: .userId) else {
            return Fail(error: ErrorVO.fatalError)
                .eraseToAnyPublisher()
        }
        return moyaProvider.call(target: .getUserInfo(id: userId))
    }
    
    public func deleteUser() -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .deleteUser)
    }
}
