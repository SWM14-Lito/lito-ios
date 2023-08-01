//
//  FileRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

final public class DefaultFileRepository: FileRepository {
    
    private let dataSource: FileDataSource
    
    public init(dataSource: FileDataSource) {
        self.dataSource = dataSource
    }
    
    public func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error> {
        dataSource.postProfileImage(profileImageDTO: profileImageDTO)
    }
}
