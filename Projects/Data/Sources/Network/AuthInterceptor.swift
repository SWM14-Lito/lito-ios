//
//  AccessTokenPlugin.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Moya
import Foundation
import Alamofire
import Domain

final class AuthInterceptor: RequestInterceptor {
    
    static let shared = AuthInterceptor()
    private let moyaProvider = MoyaWrapper<AuthAPI>(authorizationNeeded: false)
    private var cancleBag = Set<AnyCancellable>()
    
    private init() {}
    
    private func postTokenReissue() -> AnyPublisher<TokenReissueDTO, Error> {
        return moyaProvider.call(target: .reissueToken)
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        guard let lastPath = urlRequest.url?.lastPathComponent else {
            completion(.failure(NetworkErrorDTO.requestError("Invalid path")))
            return
        }
        switch lastPath {
        case "login":
            break
        case "logout":
            urlRequest.headers.add(.authorization(bearerToken: NetworkConfiguration.accessToken))
            urlRequest.headers.add(name: "REFRESH_TOKEN", value: NetworkConfiguration.refreashToken)
        case "reissue":
            urlRequest.headers.add(.authorization(NetworkConfiguration.refreashToken))
        default:
            urlRequest.headers.add(.authorization(bearerToken: NetworkConfiguration.accessToken))
        }
        print(urlRequest.headers)
        completion(.success(urlRequest))
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        postTokenReissue()
            .sink { result in
                switch result {
                case .failure(let error):
                    completion(.doNotRetryWithError(error))
                    return
                case .finished:
                    break
                }
            } receiveValue: { tokenReissueDTO in
                print("token reissued")
                KeyChainManager.create(key: .accessToken, token: tokenReissueDTO.accessToken)
                KeyChainManager.create(key: .accessToken, token: tokenReissueDTO.refreashToken)
            }
            .store(in: &cancleBag)
        completion(.retry)
    }
}
