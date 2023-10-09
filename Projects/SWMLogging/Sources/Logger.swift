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
import RxSwift

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

    private let sessionId = UUID()
    private let appVersion: String
    private let OSNameAndVersion: String
    private var cancelBag = Set<AnyCancellable>()
    private var loggingAPI: LoggingAPI
    let disposeBag = DisposeBag()
    public let hotObservable = PublishSubject<SWMLoggingScheme>()
    private var latestLogName = ""

    public init(serverUrl: String, serverPath: String, OSNameAndVersion: String, appVersion: String) {
        self.OSNameAndVersion = OSNameAndVersion
        self.appVersion = appVersion
        loggingAPI = LoggingAPI(serverUrl: serverUrl, serverPath: serverPath)
        hotObservable
//            .flatMap({ scheme -> Observable<SWMLoggingScheme> in
//                if scheme.eventLogName == self.latestLogName {
//                    return self.hotObservable
//                        .throttle(.seconds(1), scheduler: MainScheduler.instance)
//                } else {
//                    return Observable.just(scheme)
//                }
//            })
            .subscribe(onNext: { scheme in
                print("scheme", scheme)
                self.latestLogName = scheme.eventLogName
            })
            .disposed(by: disposeBag)
    }

    // throw
    public func shotLogging(_ scheme: SWMLoggingScheme, authorization: String) throws {
        do {
            hotObservable.onNext(scheme)
            loggingAPI.setScheme(try scheme.makeJson())
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
        } catch {
            throw error
        }

    }
}
