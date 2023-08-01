//
//  MyPageView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct MyPageView: View {
    
    @ObservedObject private(set) var viewModel: MyPageViewModel
    
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Divider()
            PhotoPickerView(imageData: $viewModel.imageData)
            HStack {
                Text("내 포인트: ")
                Text(viewModel.point)
                Spacer()
                Button("충전하기") {
                    // 충전 페이지로 이동
                }
            }
            .padding(20)
            List {
                ForEach(MyPageList.allCases, id: \.self) { content in
                    HStack {
                        switch content {
                        case .name:
                            Text(content.rawValue)
                            Spacer()
                            Text("김동락")
                            EmptyView()
                        case .alarm:
                            Toggle("알림받기", isOn: $viewModel.alarmStatus)
                        default:
                            Text(content.rawValue)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                }
                HStack {
                    Spacer()
                    Button("로그아웃") {
                        // 로그아웃
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button("회원탈퇴") {
                        // 회원탈퇴
                    }
                    Spacer()
                }
            }
            .listStyle(.grouped)
            Spacer()
        }.navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.large)
    }
}
