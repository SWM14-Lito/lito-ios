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

final public class DefaultSolvingProblemRepository: SolvingProblemRepository {
    
    private let dataSource: SolvingProblemDataSource
    
    public init(dataSource: SolvingProblemDataSource) {
        self.dataSource = dataSource
    }

}
