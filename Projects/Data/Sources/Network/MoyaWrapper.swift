//
//  NetworkWrapper.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine
import Domain
import Moya
import CombineMoya

class MoyaWrapper<Provider: TargetType>: MoyaProvider<Provider> {
    
    init(endpointClosure: @escaping MoyaProvider<Provider>.EndpointClosure = MoyaProvider.defaultEndpointMapping, requestClosure: @escaping MoyaProvider<Provider>.RequestClosure = MoyaProvider<Provider>.defaultRequestMapping, stubClosure: @escaping MoyaProvider<Provider>.StubClosure = MoyaProvider.neverStub, callbackQueue: DispatchQueue? = nil, session: Session = MoyaProvider<Target>.defaultAlamofireSession(), plugins: [PluginType] = [], trackInflights: Bool = false, authorizationNeeded: Bool = true, forTest: Bool = false) {
        
        let customSession: Session
        var plugins = plugins
        let authPlugin = AuthPlugin.shared
        
        plugins.append(authPlugin)
        
        if !authorizationNeeded {
            customSession = session
        } else {
            customSession = Session(interceptor: AuthInterceptor.shared)
        }
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: customSession, plugins: plugins, trackInflights: trackInflights)
    }
    
    func call<Value>(target: Provider) -> AnyPublisher<Value, Error> where Value: Decodable {
        return self.requestPublisher(target)
            .map(Value.self)
            .catch({ moyaError -> Fail in
                #if DEBUG
                print(moyaError.debugString)
                #endif
                return Fail(error: moyaError.toVO())
            })
                .eraseToAnyPublisher()
    }
    
    func call(target: Provider) -> AnyPublisher<Void, Error> {
        return self.requestPublisher(target)
            .catch({ moyaError -> Fail in
                #if DEBUG
                print(moyaError.debugString)
                #endif
                return Fail(error: moyaError.toVO())
            })
                .eraseToAnyPublisher()
                .flatMap({ response -> AnyPublisher<Void, Error> in
                    if (200..<300).contains(response.statusCode) {
                        return Just(()).setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: ErrorVO.fatalError)
                            .eraseToAnyPublisher()
                    }
                })
                    .eraseToAnyPublisher()
    }
}
