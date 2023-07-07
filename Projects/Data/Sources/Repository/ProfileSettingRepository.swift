//
//  ProfileRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

final public class DefaultProfileSettingRepository: ProfileSettingRepository {
    
    let dataSource: ProfileSettingDataSource
    
    public init(dataSource: ProfileSettingDataSource) {
        self.dataSource = dataSource
    }
}
