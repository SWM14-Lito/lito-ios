//
//  ProfileSettingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProfileSettingUseCase {
    func postProfileInfo(setProfileDTO: SetProfileDTO) -> AnyPublisher<Void, Error>
}

public final class DefaultProfileSettingUseCase: ProfileSettingUseCase {
    let repository: ProfileSettingRepository
    
    public init(repository: ProfileSettingRepository) {
        self.repository = repository
    }
    
    public func postProfileInfo(setProfileDTO: SetProfileDTO) -> AnyPublisher<Void, Error> {
        repository.postProfileInfo(setProfileDTO: setProfileDTO)
    }
}
