//
//  Source.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2023/10/02.
//

import Foundation
import Combine
import Moya
import CombineMoya

public protocol SWMLoggingScheme: Encodable {
    var eventLogName: String { get set}
    var screenName: String { get set }
    var logVersion: Int { get set }
    var logData: [String: String] {get set }
}

// protocol scheme: encodable
// click, exposure 의 상위 추상화 객체

public protocol ClickScheme: SWMLoggingScheme {
    // Business Static Paramter
}

public protocol ExposureScheme: SWMLoggingScheme {
    // Business Static Paramter
}

public protocol SWMSchemeBuilder {
    func build() -> SWMLoggingScheme
}

public class SWMLogger {

    private let serverUrl: String
    private let serverPath: String
    private let OSNameAndVersion: String
    private let moyaProvider = MoyaProvider<LoggingAPI>()
    private var cancelBag = Set<AnyCancellable>()

    public init(serverUrl: String, serverPath: String, OSNameAndVersion: String) {
        self.serverUrl = serverUrl
        self.serverPath = serverPath
        self.OSNameAndVersion = OSNameAndVersion
    }

    public func fireLogging(_ scheme: SWMLoggingScheme, authorization: String) {

            let loggingAPI = LoggingAPI(
                serverUrl: serverUrl,
                serverPath: serverPath,
                authorization: authorization,
                scheme: scheme)
            moyaProvider.requestPublisher(loggingAPI)
                .sink(receiveCompletion: { result in
                    switch result {
                    case let .failure(error):
                        print(error)
                    default: break
                    }
                }, receiveValue: { _ in
                    print("suceess")
                })
                .store(in: &cancelBag)
    }
}
