//
//  ProfileRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine
import UIKit

final public class DefaultProfileSettingRepository: ProfileSettingRepository {
    
    private let dataSource: ProfileSettingDataSource
    
    public init(dataSource: ProfileSettingDataSource) {
        self.dataSource = dataSource
    }
    
    public func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        dataSource.postProfileInfo(profileInfoDTO: profileInfoDTO)
    }
    
    public func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error> {
        return dataSource.postProfileImage(profileImageDTO: profileImageDTO)
    }
    
    public func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error> {
        dataSource.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
    }
}
