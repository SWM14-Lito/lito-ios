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
    let error: ErrorVO
    let retryAction: () -> Void
    
    public init(error: ErrorVO, retryAction: @escaping () -> Void = {}) {
        self.error = error
        self.retryAction = retryAction
    }
    
    // TODO: 정의된 Error에 따라 보여줄 view build
    // retryable Error: 로깅 + viewModel의 메소드 재실행
    // fatal Error: 로깅 + 가능한 다른 처리 필요
    
    var body: some View {
        VStack {
            Text("An Error Occured")
                .font(.title)
            Text(error.localizedString)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40).padding()
            if error == .retryableError {
                Button(action: retryAction, label: { Text("Retry").bold() })
            }
        }
    }
}
