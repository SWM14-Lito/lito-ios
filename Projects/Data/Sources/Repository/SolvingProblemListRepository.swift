//
//  SolvingProblemRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine
import UIKit

final public class DefaultSolvingProblemListRepository: SolvingProblemListRepository {
    
    private let dataSource: SolvingProblemListDataSource
    
    public init(dataSource: SolvingProblemListDataSource) {
        self.dataSource = dataSource
    }

}