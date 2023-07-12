//
//  ExampleViewModel.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine
import Domain

final public class ExampleViewModel: ObservableObject {
    
    @Published private(set) var slip: Loadable<SlipVO>
    
    private let exampleUseCase: ExampleUseCase
    private let cancelBag = CancelBag()
    
    public init(exampleUseCase: ExampleUseCase, slip: Loadable<SlipVO> = .notRequested) {
        self.slip = slip
        self.exampleUseCase = exampleUseCase
    }
    
    func loadSlip() {
        slip.setIsLoading(cancelBag: cancelBag)
        exampleUseCase.load()
            .receive(on: DispatchQueue.main)
            .sinkToLoadable {
                self.slip = $0
            }
            .store(in: cancelBag)
    }
}
