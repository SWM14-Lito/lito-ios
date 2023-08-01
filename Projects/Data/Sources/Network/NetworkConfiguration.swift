//
//  NetworkConfiguration.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Domain

enum NetworkConfiguration {
    static let developmentServerURL = Bundle.main.infoDictionary?["DEVELOPMENT_SERVER_URL"] ?? ""
    static var accessToken: String {
        return KeyChainManager.read(key: .accessToken) ?? ""
    }
    static var refreashToken: String {
        return KeyChainManager.read(key: .refreshToken) ?? ""
    }
}
