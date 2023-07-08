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
    
    public func postProfileInfo(profileSettingVO: ProfileSettingVO) -> AnyPublisher<Void, Error> {
        dataSource.postProfileInfo(profileInfo: profileSettingVO)
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
