//
//  HomeViewModel.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//


import Foundation
import Combine
import Domain

final public class HomeViewModel: ObservableObject {
        
        @Published var slip: Loadable<SlipVO>
        
        private let homeUseCase: HomeUseCase
        private let cancelBag = CancelBag()
        
        public init(homeUseCase: HomeUseCase, slip: Loadable<SlipVO> = .notRequested) {
            self.slip = slip
            self.homeUseCase = homeUseCase
        }
        
        func loadSlip() {
            homeUseCase.load()
                .receive(on: DispatchQueue.main)
                .sinkToLoadable {
                    self.slip = $0
                }
                .store(in: cancelBag)
        }
}
