//
//  ErrorVisable.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/05.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Domain

class ErrorObject: ObservableObject {
    @Published var error: ErrorVO?
    @Published var retryAction: () -> Void = {}
}
