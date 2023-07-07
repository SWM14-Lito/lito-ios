//
//  LoginUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol LoginUseCase {
    
    func kakaoLogin() -> AnyPublisher<RequestResultVO, ErrorVO>
    func appleLogin() -> AnyPublisher<RequestResultVO, ErrorVO>
    
}

// TODO: 유저 정보 keychain 저장
public final class DefaultLoginUseCase: LoginUseCase {
    
    let repository: LoginRepository
    
    private var cancleBag = Set<AnyCancellable>()
    
    public init(repository: LoginRepository) {
        self.repository = repository
    }
    
    public func appleLogin() -> AnyPublisher<RequestResultVO, ErrorVO> {
        repository.appleLogin()
            .map { _ in .succeed }
            .eraseToAnyPublisher()
    }
    
    public func kakaoLogin() -> AnyPublisher<RequestResultVO, ErrorVO> {
        repository.kakaoLogin()
            .map { _ in .succeed }
            .eraseToAnyPublisher()
    }
    
}
