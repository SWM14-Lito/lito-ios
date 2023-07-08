//
//  ProfileRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProfileSettingRepository {
    func postProfileInfo(profileSettingVO: ProfileSettingVO) -> AnyPublisher<Void, Error>
}
