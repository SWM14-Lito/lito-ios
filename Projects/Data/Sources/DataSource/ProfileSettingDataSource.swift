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
    func postProfileInfo(setProfileDTO: SetProfileDTO) -> AnyPublisher<Void, Error>
}

public class DefaultProfileSettingDataSource: ProfileSettingDataSource {
    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProfileAPI>()
    
    public func postProfileInfo(setProfileDTO: SetProfileDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .setProfile(setProfileDTO: setProfileDTO))
    }
}
