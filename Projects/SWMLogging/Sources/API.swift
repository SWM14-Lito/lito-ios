//
//  API.swift
//  SWMLogging
//
//  Created by Lee Myeonghwan on 2023/10/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Moya

struct LoggingAPI: TargetType {
    let serverUrl: String
    let serverPath: String
    let authorization: String
    let scheme: SWMLoggingScheme

    var baseURL: URL {
        return URL(string: serverUrl)!
    }

    var path: String {
        return serverPath
    }

    var method: Moya.Method {
        return .post
    }

    var task: Moya.Task {
        return .requestJSONEncodable(scheme)
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(authorization)"]
    }

}
