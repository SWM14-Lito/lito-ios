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
    
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            if let error = subscriptionCompletion.error {
                switch error {
                case .fatalError:
                    completion(.failed(.fatalError))
                case .retryableError:
                    completion(.failed(.retryableError))
                }
            }
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
    
    /// Holds the downstream delivery of output until the specified time interval passed after the subscription
    /// Does not hold the output if it arrives later than the time threshold
    ///
    /// - Parameters:
    ///   - interval: The minimum time interval that should elapse after the subscription.
    /// - Returns: A publisher that optionally delays delivery of elements to the downstream receiver.
    
    func ensureTimeSpan(_ interval: TimeInterval) -> AnyPublisher<Output, Failure> {
        let timer = Just<Void>(())
            .delay(for: .seconds(interval), scheduler: RunLoop.main)
            .setFailureType(to: Failure.self)
        return zip(timer)
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
}

extension Subscribers.Completion {
    var error: NetworkErrorVO? {
        switch self {
        case let .failure(error):
            return error as? NetworkErrorVO
        default: return nil
        }
    }
}
