//
//  UserRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol UserRepository {
    func postUserInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error>
    func patchUserInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error>
    func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error>
    func getUserInfo() -> AnyPublisher<UserInfoVO, Error>
    func deleteUser() -> AnyPublisher<Void, Error>
}
