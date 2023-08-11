//
//  MyPageViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Domain
import Kingfisher

public class MyPageViewModel: BaseViewModel {
    
    private let useCase: MyPageUseCase
    @Published var userInfo: UserInfoVO?
    @Published var imageData: Data?
    @Published var alarmStatus: Bool = true
    
    public init(useCase: MyPageUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    public func getUserInfo() {
        useCase.getUserInfo()
            .sinkToResult { result in
                switch result {
                case .success(let userInfoVO):
                    self.userInfo = userInfoVO
                    self.alarmStatus = userInfoVO.alarmStatus
                    if let imageUrl = URL(string: userInfoVO.profileImgUrl) {
                        KingfisherManager.shared.retrieveImage(with: imageUrl) { result in
                            switch result {
                            case .success(let value):
                                if let imageData = value.image.pngData() {
                                    self.imageData = imageData
                                }
                            case .failure:
                                break
                            }
                        }
                    }
                case .failure:
                    break
                }
            }
            .store(in: cancelBag)
    }
    
    public func postLogout() {
        useCase.postLogout()
            .sinkToResult { result in
                switch result {
                case .success:
                    KeyChainManager.deleteUserInfo()
                    self.coordinator.popToRoot()
                case .failure:
                    break
                }
            }
            .store(in: cancelBag)
    }
    
    public func moveToModifyProfileView() {
        coordinator.push(.modifyProfileScene)
    }
    
}
