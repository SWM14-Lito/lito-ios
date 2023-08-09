//
//  File.swift
//  Data
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Moya
import Domain
import Foundation

enum ChatAPI {
    case chattingWithChatCPT(SendingQuestionDTO)
}
extension ChatAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .chattingWithChatCPT:
            return "/api/v1/chat-gpt/1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .chattingWithChatCPT:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .chattingWithChatCPT(let sendingQuestionDTO):
            return .requestParameters(
                parameters: ["message": sendingQuestionDTO.message],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .chattingWithChatCPT:
            return APIConfiguration.jsonContentType
        }
    }
}
