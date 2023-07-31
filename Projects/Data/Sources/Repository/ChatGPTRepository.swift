//
//  ChattingRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine

final public class DefaultChatGPTRepository: ChatGPTRepository {
    
    private let dataSource: ChatGPTDataSource
    
    public init(dataSource: ChatGPTDataSource) {
        self.dataSource = dataSource
    }
}
