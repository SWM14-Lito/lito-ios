//
//  AuthRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol AuthRepository {
    func postLoginInfo(OAuthProvider: OAuth) -> AnyPublisher<LoginVO, Error>
    func postLogout() -> AnyPublisher<Void, Error>
}
