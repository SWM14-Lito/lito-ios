//
//  BTabCoordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Combine

fileprivate extension Notification.Name {
    static let popToBTabRoot = Notification.Name("PopToBTabRoot")
}

enum BTabDestination {
    case firstView
    case secondView
    case thirdView
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .firstView:
            BTabFirstView()
        case .secondView:
            BTabSecondView()
        case .thirdView:
            BTabThirdView()
        }
    }
}

final class BTabCoordinator: ObservableObject {
    private var destination: BTabDestination = .firstView
    private let isRoot: Bool
    private var cancellable: Set<AnyCancellable> = []
    @Published private var navigationTrigger = false
    @Published private var rootNavigationTrigger = false
    
    init(isRoot: Bool = false) {
        self.isRoot = isRoot
        
        if isRoot {
            NotificationCenter.default.publisher(for: .popToBTabRoot)
                .sink { [unowned self] _ in
                    rootNavigationTrigger = false
                }
                .store(in: &cancellable)
        }
    }
    
    @ViewBuilder
    func navigationLinkSection() -> some View {
        NavigationLink(isActive: Binding<Bool>(get: getTrigger, set: setTrigger(newValue:))) {
            destination.view
        } label: {
            EmptyView()
        }
    }
    
    func popToRoot() {
        NotificationCenter.default.post(name: .popToBTabRoot, object: nil)
    }
    
    func push(destination: BTabDestination) {
        self.destination = destination
        if isRoot {
            rootNavigationTrigger.toggle()
        } else {
            navigationTrigger.toggle()
        }
    }
    
    private func getTrigger() -> Bool {
        isRoot ? rootNavigationTrigger : navigationTrigger
    }
    
    private func setTrigger(newValue: Bool) {
        if isRoot {
            rootNavigationTrigger = newValue
        } else {
            navigationTrigger = newValue
        }
    }
}

