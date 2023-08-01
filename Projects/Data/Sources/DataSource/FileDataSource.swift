//
//  FileDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol FileDataSource {
    func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error>
}

final public class DefaultFileDataSource: FileDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<FileAPI>()
    
    public func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error> {
        moyaProvider.call(target: .setProfileImage(profileImageDTO))
    }
}
