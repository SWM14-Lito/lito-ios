//
//  ChatRepository.swift
//  Data
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

final public class DefaultChatRepository: ChatRepository {
    
    private let dataSource: ChatDataSource
    
    public init(dataSource: ChatDataSource) {
        self.dataSource = dataSource
    }
    
    public func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error> {
        dataSource.postProfileImage(profileImageDTO: profileImageDTO)
    }
}
