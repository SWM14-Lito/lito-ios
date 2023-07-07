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
    
    public func appleLogin() -> AnyPublisher<OAuth.AppleVO, Error> {
        dataSource.appleLogin()
            // 1차적으로 이곳에서 oauthErrorDTO 를 핸들링
            // 만약 catch한 error 가 추가적인 액션을 통해 해결 가능성 있는 error 라면 repository or useCase 어디서 처리 해야할까?
            .catch({ error -> Fail in
                if let oauthErrorDTO = error as? OAuthErrorDTO {
                    #if DEBUG
                    print(oauthErrorDTO.debugString)
                    #endif
                    return Fail(error: oauthErrorDTO.toVO())
                }
                return Fail(error: ErrorVO.fatalError)
            })
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
    public func kakaoLogin() -> AnyPublisher<OAuth.KakaoVO, Error> {
        dataSource.kakaoLogin()
            .catch({ error -> Fail in
                if let oauthError = error as? OAuthErrorDTO {
                    #if DEBUG
                    print(oauthError.debugString)
                    #endif
                    return Fail(error: oauthError.toVO())
                }
                return Fail(error: ErrorVO.fatalError)
            })
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
    
}
