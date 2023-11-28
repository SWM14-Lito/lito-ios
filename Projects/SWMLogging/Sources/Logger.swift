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
    var eventLogName: String { get set }
    var screenName: String { get set }
    var logVersion: Int { get set }
    var logData: [String: AnyEncodable] { get set }
}

extension SWMLoggingScheme {
    func makeJson() throws -> Data {
        return try SWMLogger.encoder.encode(self)
    }
}

public protocol ClickScheme: SWMLoggingScheme {
    // Business Static Paramter
}

public protocol ExposureScheme: SWMLoggingScheme {
    // Business Static Paramter
}

public class SWMLogger {

    static let encoder = JSONEncoder()
    private let moyaProvider = MoyaProvider<LoggingAPI>()
    private let throttleLimit = 1.0

    private let sessionId = UUID()
    private let appVersion: String
    private let OSNameAndVersion: String

    private var cancelBag = Set<AnyCancellable>()
    private var loggingAPI: LoggingAPI
    private var latestLogName = ""
    private var latestShotTime = Date()

    public init(serverUrl: String, serverPath: String, OSNameAndVersion: String, appVersion: String) {
        self.OSNameAndVersion = OSNameAndVersion
        self.appVersion = appVersion
        loggingAPI = LoggingAPI(serverUrl: serverUrl, serverPath: serverPath)
    }

    public func shotLogging(_ scheme: SWMLoggingScheme, authorization: String) throws {
        do {
            if throttleCondition(scheme.eventLogName) {
                latestShotTime = Date()
                latestLogName = scheme.eventLogName
                loggingAPI.setScheme(try scheme.makeJson())
                loggingAPI.setAuthorization(authorization)
                sendRequest(loggingAPI)
            }
        } catch {
            throw error
        }
    }

    private func throttleCondition(_ eventLogName: String) -> Bool {
        (eventLogName == latestLogName && Date().timeIntervalSince(latestShotTime) > throttleLimit) ||
        (eventLogName != latestLogName)
    }

    private func sendRequest(_ api: LoggingAPI) {
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
