//
//  ChatGPTUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol ChattingUseCase {

}

public final class DefaultChattingUseCase: ChattingUseCase {
    private let repository: ChatGPTRepository
    
    public init(repository: ChatGPTRepository) {
        self.repository = repository
    }
}
