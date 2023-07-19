//
//  ProblemSolvingDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol ProblemSolvingDataSource {

}

final public class DefaultProblemSolvingDataSource: ProblemSolvingDataSource {
    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProfileSettingAPI>()
}
