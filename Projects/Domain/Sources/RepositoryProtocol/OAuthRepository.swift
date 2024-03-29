//
//  OAuthRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol OAuthRepository {
    func appleLogin() -> AnyPublisher<OAuth.AppleVO, Error>
    func kakaoLogin() -> AnyPublisher<OAuth.KakaoVO, Error>
}
