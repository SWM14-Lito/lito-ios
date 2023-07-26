//
//  AccessTokenPlugin.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Moya
import Foundation
import Alamofire

final class AuthInterceptor: RequestInterceptor {

    static let shared = AuthInterceptor()

    private init() {}

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue(NetworkConfiguration.accessToken, forHTTPHeaderField: "accessToken")
        urlRequest.setValue(NetworkConfiguration.refreashToken, forHTTPHeaderField: "refreshToken")
        completion(.success(urlRequest))
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
    }
}
