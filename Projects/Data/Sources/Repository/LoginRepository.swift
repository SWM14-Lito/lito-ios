//
//  LoginRepository.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation
import Domain

final public class DefaultLoginRepository: LoginRepository {
    
    private let dataSource: OAuthServiceDataSource
    
    public init(dataSource: OAuthServiceDataSource) {
        self.dataSource = dataSource
    }
    
    public func performAppleLogin() {
        dataSource.performAppleLogin()
    }
    
    public func bindAppleLogin() -> AnyPublisher<Result<OAuth.AppleVO, ErrorVO>, Never> {
        dataSource.appleLoginSubject
            .map { result in
                switch result {
                case .success(let appleDTO):
                    return .success(appleDTO.toVO())
                case .failure(let errorVO):
                    return .failure(errorVO)
                }
            }
            .eraseToAnyPublisher()
    }

    public func kakaoLogin() -> AnyPublisher<OAuth.KakaoVO, ErrorVO> {
        dataSource.kakaoLogin()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
}
