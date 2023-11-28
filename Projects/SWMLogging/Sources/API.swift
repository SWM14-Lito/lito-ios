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
    private let serverUrl: String
    private let serverPath: String
    private var authorization: String?
    private var schemeData: Data = Data()

    public init(serverUrl: String, serverPath: String) {
        self.serverUrl = serverUrl
        self.serverPath = serverPath
    }

    public mutating func setScheme(_ schemeData: Data) {
        self.schemeData = schemeData
    }

    public mutating func setAuthorization(_ authorization: String) {
        self.authorization = authorization
    }

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
        return .requestData(schemeData)
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(authorization ?? "")"]
    }

}
