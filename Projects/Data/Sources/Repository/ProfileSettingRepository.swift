//
//  ProfileRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine

final public class DefaultProfileSettingRepository: ProfileSettingRepository {
    
    let dataSource: ProfileSettingDataSource
    
    public init(dataSource: ProfileSettingDataSource) {
        self.dataSource = dataSource
    }
    
    public func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        dataSource.postProfileInfo(profileInfoDTO: profileInfoDTO)
            .catch { error -> Fail in
                if let networkError = error as? NetworkErrorDTO {
                    #if DEBUG
                    print(networkError.debugString)
                    #endif
                    return Fail(error: networkError)
                }
                return Fail(error: ErrorVO.fatalError)
            }
            .eraseToAnyPublisher()
    }
    
    public func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error> {
        dataSource.postProfileImage(profileImageDTO: profileImageDTO)
            .catch { error -> Fail in
                if let networkError = error as? NetworkErrorDTO {
                    #if DEBUG
                    print(networkError.debugString)
                    #endif
                    return Fail(error: networkError)
                }
                return Fail(error: ErrorVO.fatalError)
            }
            .eraseToAnyPublisher()
    }
    
    public func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error> {
        dataSource.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
            .catch { error -> Fail in
                if let networkError = error as? NetworkErrorDTO {
                    #if DEBUG
                    print(networkError.debugString)
                    #endif
                    return Fail(error: networkError)
                }
                return Fail(error: ErrorVO.fatalError)
            }
            .eraseToAnyPublisher()
    }
}
