//
//  FileAPI.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Moya
import Domain
import Foundation

enum FileAPI {
    case setProfileImage(ProfileImageDTO)
}
extension FileAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .setProfileImage:
            return "/api/v1/users/files"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setProfileImage:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .setProfileImage(let profileImageDTO):
            let imgData = MultipartFormData(provider: .data(profileImageDTO.image), name: "file", fileName: "image.png", mimeType: "image/png")
            return .uploadMultipart([imgData])
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .setProfileImage(let profileImageDTO):
            return ["Authorization": "Bearer \(profileImageDTO.accessToken)", "Content-type": "multipart/form-data;charset=UTF-8; boundary=6o2knFse3p53ty9dmcQvWAIx1zInP11uCfbm"]
        }
    }
    
    var pathWithMethod: String {
        return self.path + self.method.rawValue
    }
}
