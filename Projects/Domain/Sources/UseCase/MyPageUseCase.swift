//
//  MyPageUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol MyPageUseCase {
    func postLogout() -> AnyPublisher<Void, Error>
    func getUserInfo() -> AnyPublisher<UserInfoVO, Error>
}

public final class DefaultMyPageUseCase: MyPageUseCase {
    private let userRepository: UserRepository
    private let authRepository: AuthRepository
    
    public init(userRepository: UserRepository, authRepository: AuthRepository) {
        self.userRepository = userRepository
        self.authRepository = authRepository
    }
    
    public func getUserInfo() -> AnyPublisher<UserInfoVO, Error> {
        userRepository.getUserInfo()
    }
    
    public func postLogout() -> AnyPublisher<Void, Error> {
        authRepository.postLogout()
    }
}
