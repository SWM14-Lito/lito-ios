//
//  SovingProblemUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation
import SWMLogging

public protocol SolvingProblemListUseCase {
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<SolvingProblemListVO, Error>
    func fireLogging(scheme: SWMLoggingScheme)
}

public final class DefaultSolvingProblemListUseCase: SolvingProblemListUseCase {
//    let logging = SWMLogging
    public func fireLogging(scheme: SWMLogging.SWMLoggingScheme) {
//        let builder = OrderClickedBuilder
        logger.fireLogging(scheme, authorization: "eyJhbGciOiJIUzI1NiJ9.eyJnaXRodWJJZCI6Ikt4eEh5b1JpbSIsImlhdCI6MTY5NTcxNDE1MiwiZXhwIjoxNzI3MjUwMTUyfQ.tbQFKNIQCekhWZjHwOqQNBIY3YgXZZm-B95NyTvBn5c")
    }
    
    private let repository: ProblemRepository
    private let logger: SWMLogger
    
    public init(repository: ProblemRepository, logger: SWMLogger) {
        self.repository = repository
        self.logger = logger
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
    
    public func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<SolvingProblemListVO, Error> {
        repository.getProblemList(problemsQueryDTO: problemsQueryDTO)
    }
    
    // protocol scheme: encodable
    // click, exposure 의 상위 추상화 객체
//    public func fireLogging(scheme: Scheme) {
//        SWMLogging.fireLogging(scheme: <#T##Scheme#>)
//    }
}
