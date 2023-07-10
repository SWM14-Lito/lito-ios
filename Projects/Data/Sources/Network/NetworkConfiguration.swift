//
//  NetworkConfiguration.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

enum NetworkConfiguration {
    static let developServerURL = Bundle.main.infoDictionary?["DEVELOPMENT_SERVER_URL"] ?? ""
}
