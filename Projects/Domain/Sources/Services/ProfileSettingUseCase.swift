//
//  ProfileSettingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

public protocol ProfileSettingUseCase {
   
}

public final class DefaultProfileSettingUseCase: ProfileSettingUseCase {
    let repository: ProfileSettingRepository
    
    public init(repository: ProfileSettingRepository) {
        self.repository = repository
    }
}
