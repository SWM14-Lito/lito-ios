//
//  Publisher+Extension.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/21.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine
import Domain

extension Publisher {
    
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
    
    func sinkToResultWithHandler(_ result: @escaping (Result<Output, Failure>) -> Void, errorHandler: @escaping (Failure) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                errorHandler(error)
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
    
    func sinkToResultWithErrorHandler(_ result: @escaping (Output) -> Void, errorHandler: @escaping (Failure) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                errorHandler(error)
            default: break
            }
        }, receiveValue: { value in
            result(value)
        })
    }
    
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            if let error = subscriptionCompletion.error {
                completion(.failed(error))
            }
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
    
}

extension Subscribers.Completion {
    var error: ErrorVO? {
        switch self {
        case let .failure(error):
            return error as? ErrorVO
        default: return nil
        }
    }
}
