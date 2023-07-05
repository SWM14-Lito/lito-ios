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
    func performAppleLogin()
    func bindAppleLogin() -> AnyPublisher<Result<RequestResultVO, ErrorVO>, Never>
    
}

// TODO: 유저 정보 keychain 저장
public final class DefaultLoginUseCase: LoginUseCase {
    
    let repository: LoginRepository
    
    private var cancleBag = Set<AnyCancellable>()
    
    public init(repository: LoginRepository) {
        self.repository = repository
    }
    
    public func performAppleLogin() {
        repository.performAppleLogin()
    }
    
    public func bindAppleLogin() -> AnyPublisher<Result<RequestResultVO, ErrorVO>, Never> {
        repository.bindAppleLogin()
            .map { result in
                switch result {
                case .success(_):
                    return .success(.successed)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func kakaoLogin() -> AnyPublisher<RequestResultVO, ErrorVO> {
        repository.kakaoLogin()
            .map { _ in .successed }
            .eraseToAnyPublisher()
    }
    
}
