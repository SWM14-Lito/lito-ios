//
//  HomeDataSource.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine

public protocol HomeDataSource {
    func loadMaxim() -> AnyPublisher<SlipDTO, Error>
}

public class DefaultHomeDataSource: ServerDataSource, HomeDataSource {
    
    public let session: URLSession
    public let baseURL: String
    public let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    public init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    public func loadMaxim() -> AnyPublisher<SlipDTO, Error> {
        return call(endpoint: API.oneSlip)
    }
    
}

extension DefaultHomeDataSource {
    enum API {
        case oneSlip
    }
}

extension DefaultHomeDataSource.API: APICall {
    
    var path: String {
        switch self {
        case .oneSlip:
            return ""
        }
    }
    var method: String {
        switch self {
        case .oneSlip:
            return "GET"
        }
    }
    var headers: [String: String]? {
        return APICallHeaders.Json
    }
    func body() throws -> Data? {
        return nil
    }
}
