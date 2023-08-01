//
//  MyPageViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public class MyPageViewModel: BaseViewModel {
    @Published var imageData: Data?
    @Published var point: String = "0"
    @Published var nickName: String = "Unknown"
    @Published var introduce: String = "Unknown"
    @Published var alarmStatus: Bool = true
}
