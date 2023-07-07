//
//  File.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Combine

public protocol LoginRepository {
    
    func appleLogin() -> AnyPublisher<OAuth.AppleVO, Error>
    func kakaoLogin() -> AnyPublisher<OAuth.KakaoVO, Error>
    
}
