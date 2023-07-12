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
    
    public init() {}
    
    // TODO: 정의된 Error에 따라 보여줄 view build
    // retryable Error: 로깅 + viewModel의 메소드 재실행
    // fatal Error: 로깅 + 가능한 다른 처리 필요
    
    var body: some View {
        VStack {
            if let error = errorObject.error {
                Text("An Error Occured")
                    .font(.title)
                    .padding(20)
                Text(error.localizedString)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                if errorObject.error == .retryableError {
                    Button(action: errorObject.retryAction, label: { Text("Retry").bold() })
                }
            }
        }
    }
}
