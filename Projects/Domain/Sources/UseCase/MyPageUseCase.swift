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
}

public final class DefaultMyPageUseCase: MyPageUseCase {
    private let repository: AuthRepository
    
    public init(repository: AuthRepository) {
        self.repository = repository
    }
    
    public func postLogout() -> AnyPublisher<Void, Error> {
        repository.postLogout()
    }
}
