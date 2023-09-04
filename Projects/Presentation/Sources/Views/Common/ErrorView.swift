//
//  ErrorView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/29.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import SwiftUI
import Domain

struct ErrorView: View {
//    let error: ErrorVO
    @ObservedObject var errorObject: ErrorObject = ErrorObject()
    
    public init(errorObject: ErrorObject) {
        self.errorObject = errorObject
    }
    
    // retryable Error: 로깅 + viewModel의 메소드 재실행
    // fatal Error: 로깅 + 가능한 다른 처리 필요
    
    var body: some View {
        VStack(spacing: 0) {
            if let error = errorObject.error {
                Text("에러가 발생했습니다.")
                    .font(.title)
                Text(error.localizedString)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding(20)
                
                if case .retryableError = errorObject.error {
                    Button(action: errorObject.retryAction, label: { Text("다시 시도하기").bold() })
                }
            }
        }
    }
}
