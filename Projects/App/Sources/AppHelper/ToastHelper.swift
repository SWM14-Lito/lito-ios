//
//  ToastHelper.swift
//  App
//
//  Created by 김동락 on 2023/08/22.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Presentation
import Combine

public class ToastHelper: ObservableObject, ToastHelperProtocol {
    var toastMessage: String
    var duration: Double
    @Published public var isToastShown: Bool
    
    public init(toastMessage: String = "", duration: Double = 2.0, isToastShown: Bool = false) {
        self.toastMessage = toastMessage
        self.duration = duration
        self.isToastShown = isToastShown
    }
    
    public func setMessage(_ message: String) {
        toastMessage = message
    }
    
    public func setDuration(_ time: Double) {
        duration = time
    }
    
    public func showToast() {
        isToastShown = true
    }
}
