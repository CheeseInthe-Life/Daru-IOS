//
//  AppFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/05/15.
//

import UIKit
import RxFlow

final class AppFlow: Flow {
    
    var root: Presentable {
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    
    init(window: UIWindow) {
        self.rootWindow = window
    }
    
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case .mainIsRequired:
            return navigationToMainScene()
        default:
            return .none
        }
        
    }
    
}

extension AppFlow {
    func navigationToMainScene() -> FlowContributors {
        let mainFlow = MainFlow()
        Flows.use(mainFlow, when: .created) { [weak self] flowRoot in
            self?.rootWindow.rootViewController = flowRoot
        }
        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: OneStepper(withSingleStep: DaruStep.mainIsRequired)))
    }
}
