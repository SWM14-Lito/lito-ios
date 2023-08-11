//
//  ModifyProfileView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ModifyProfileView: View {
    
    @ObservedObject private(set) var viewModel: MyPageViewModel
    
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        if let userInfo = viewModel.userInfo {
            ScrollView {
                Divider()
                    .foregroundColor(.Divider_Default)
                    .padding(.top, 15)
                    .padding(.bottom, 39)
                VStack(spacing: 0) {
                    HStack {
                        Text("이름")
                            .font(.Body2SemiBold)
                        Spacer()
                    }
                    .padding(.bottom, 6)
                    HStack {
                        Text(userInfo.name)
                            .font(.Body2Regular)
                            .foregroundColor(.Text_Disabled)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.Bg_Deep)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.Border_Default, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
            }
            .modifier(CustomNavigation(title: "정보 수정", back: viewModel.back))
        } else {
            EmptyView()
        }
    }
}
