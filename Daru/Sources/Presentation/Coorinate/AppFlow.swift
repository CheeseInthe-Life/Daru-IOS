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
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
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
        let tabVC = TabViewController()
        let mainFlow = MainFlow(tabViewController: tabVC)
        let naviVC = UINavigationController()
        rootWindow.rootViewController = naviVC
        Flows.use(mainFlow, when: .created) { flowRoot in
            naviVC.pushViewController(flowRoot, animated: false)
        }
        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: CompositeStepper(steppers: [
            OneStepper(withSingleStep: DaruStep.mainIsRequired),
            tabVC
        ])))
    }
}
